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


@interface PAYFormTableViewController ()

@property (nonatomic, retain) PAYFormTable *table;

@end


@implementation PAYFormTableViewController

- (void)loadView {
    self.tableView = [[PAYFormTableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                       style:UITableViewStyleGrouped];
    self.view = self.tableView;
    
    self.defaultRowHeight    = 44.0f;
    self.defaultFooterHeight = 36.0f;
    
    self.tableView.accessibilityLabel = @"PAYFormTable";
    self.tableView.isAccessibilityElement = YES;
}

- (void)viewDidLoad {
    [self initForm];
    [self loadStructure];
    
    [super viewDidLoad];
    
    [self.tableView enableTapToEndEditing];
    
    [self buildFooter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleFormRowFocusRequest:)
                                               name:PAYFormRowFocusRequestNotification
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
    tableBuilder.defaultBounds = CGRectMake(0, 0,
                                            self.view.frame.size.width,
                                            self.defaultRowHeight);
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
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0,
                                  self.view.frame.size.width,
                                  self.defaultFooterHeight);
    footerView.backgroundColor = UIColor.clearColor;
    
    self.tableView.tableFooterView = footerView;
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
    return formSection.header.view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PAYFormSection *formSection = self.table.sections[section];
    return formSection.views.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PAYFormRow> formRow = [self formRowForIndexPath:indexPath];
    return formRow.view;
}


#pragma mark - UITableViewDelegate's implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PAYFormRow> formRow = [self formRowForIndexPath:indexPath];
    if ([formRow respondsToSelector:@selector(didSelectRow)]) {
        [formRow didSelectRow];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PAYFormSection *formSection = self.table.sections[section];
    return formSection.header.view.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *fieldView = [self formRowForIndexPath:indexPath].view;
    return fieldView.frame.size.height;
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
     
- (void)scrollToCell:(UITableViewCell *)cell {
    NSIndexPath *scrollIndexPath = [self.tableView indexPathForRowAtPoint:cell.center];
    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - PAYFormViewController's implementation

- (void)onDone:(id)sender {
    [self.table validate];
}

@end
