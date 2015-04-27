//
//  PAYFormTableViewController.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 29.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTableViewController.h"
#import "UIView+PAYKeyboardHandling_protected.h"
#import "PAYFormTable.h"
#import "PAYFormTableBuilder_protected.h"
#import "PAYFormField.h"
#import "PAYFormTableView.h"
#import "PAYNotifications.h"
#import "PAYFormView_protected.h"
#import "PAYStyle.h"


@interface PAYFormTableViewController ()

@property (nonatomic, retain) PAYFormTable *table;

@end


@implementation PAYFormTableViewController

- (void)loadView {
    self.tableView = [[PAYFormTableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped];
    self.view = self.tableView;
    
    self.tableView.accessibilityLabel = @"PAYFormTable";
    self.tableView.isAccessibilityElement = YES;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 36.0;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
}

- (void)viewDidLoad {
    [self initForm];
    [self loadStructure];
    
    [super viewDidLoad];
    
    [self.tableView enableTapToEndEditing];
    
    [self buildFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleFormRowFocusRequest:)
                                               name:PAYFormRowFocusRequestNotification
                                             object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleChangeRowHeightBeginRequest:)
                                               name:PAYFormRowHeightChangeBeginNotification
                                             object:nil];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleChangeRowHeightEndRequest:)
                                               name:PAYFormRowHeightChangeEndNotification
                                             object:nil];
    
    if (self.table.selectFirstField) {
        PAYFormSection *firstSection = self.table.sections.firstObject;
        [firstSection.firstFormField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)loadStructure {
    PAYFormTableBuilder *tableBuilder = [PAYFormTableBuilder new];
    [self loadStructure:tableBuilder];
    
    self.table = tableBuilder.table;
    [self.table initSectionJumpOrder];
}

- (void)reloadStructure {
    [self.table.sections removeAllObjects];
    [self loadStructure];
    [self.tableView reloadData];
}

- (void)buildFooter {
    if (!self.tableView.tableFooterView) {
        UIView *footerView = [UIView new];
        footerView.frame = CGRectMake(0, 0, 0, PAYStyle.tableTheme.footerHeight);
        footerView.backgroundColor = UIColor.clearColor;
        
        self.tableView.tableFooterView = footerView;
    }
}

- (void)initForm {
    // Empty stub implementation.
}

- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {
    // Empty stub implementation.
}

#pragma mark - UITableViewDataSource's implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.table.sections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PAYFormSection *formSection = self.table.sections[section];
    return formSection.header.header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PAYFormSection *formSection = self.table.sections[section];
    return formSection.views.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PAYFormRow> formRow = [self formRowForIndexPath:indexPath];
    return formRow.cell;
}

#pragma mark - UITableViewDelegate's implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PAYFormRow> formRow = [self formRowForIndexPath:indexPath];
    if ([formRow respondsToSelector:@selector(didSelectRow)]) {
        [formRow didSelectRow];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *fieldView = [self formRowForIndexPath:indexPath].cell;
    CGSize size = [fieldView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 0.5f;
}

#pragma mark - View management

- (id<PAYFormRow>)formRowForIndexPath:(NSIndexPath *)indexPath {
    PAYFormSection *section = self.table.sections[indexPath.section];
    id<PAYFormRow> formRow = section.views[indexPath.row];
    return formRow;
}

- (void)handleFormRowFocusRequest:(NSNotification *)notfication {
    [self scrollToCell:notfication.object];
}

- (void)handleChangeRowHeightBeginRequest:(NSNotification *)notification{
    [self.tableView beginUpdates];
}

- (void)handleChangeRowHeightEndRequest:(NSNotification *)notification{
    [self.tableView endUpdates];
}

- (void)scrollToCell:(UITableViewCell *)cell {
    NSIndexPath *scrollIndexPath = [self.tableView indexPathForRowAtPoint:cell.center];
    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - PAYFormViewController's implementation

- (void)onDone:(id)sender {
    [self.table validate];
}

#pragma mark - Layout header view

- (void)updateViewConstraints {
    if (self.tableView.tableHeaderView) {
        self.tableView.tableHeaderView = [self updateFixedHeightOfView:self.tableView.tableHeaderView];
    }
    if (self.tableView.tableFooterView) {
        self.tableView.tableFooterView = [self updateFixedHeightOfView:self.tableView.tableFooterView];
    }
    
    [super updateViewConstraints];
}

- (UIView *)updateFixedHeightOfView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view setNeedsLayout];
    [view layoutIfNeeded];
    
    NSArray *temporaryWidthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[view(width)]"
                                                                                 options:0
                                                                                 metrics:@{@"width": @(view.bounds.size.width)}
                                                                                   views:@{@"view": view}];
    [view addConstraints:temporaryWidthConstraints];
    
    CGFloat height = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    [view removeConstraints:temporaryWidthConstraints];
    view.translatesAutoresizingMaskIntoConstraints = YES;
    
    view.frame = CGRectMake(0, 0, view.frame.size.width, height);
    
    return view;
}

@end
