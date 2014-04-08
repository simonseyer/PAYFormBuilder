//
//  PAYFormTableViewController.m
//  paij
//
//  Created by Simon Seyer on 29.10.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormTableViewController.h"
#import "UIView+PAYKeyboardHandling.h"
#import "PAYFormTable.h"
#import "PAYFormTableBuilder.h"
#import "PAYFormField.h"
#import "PAYFormTableView.h"


const CGFloat PAYFormTableViewControllerDefaultFooterHeight = 36.0;
const CGFloat PAYFormTableViewControllerDefaultRowHeight    = 44.0;


@implementation PAYFormTableViewController

- (void)loadView {
    self.tableView = [[PAYFormTableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                       style:UITableViewStyleGrouped];
    self.view = self.tableView;
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
    
    if (self.table.selectFirstField) {
        PAYFormSection *firstSection = self.table.sections.firstObject;
        [firstSection.firstFormField becomeFirstResponder];
    }
}

- (void)initForm {
    // Empty stub implementation.
}

- (void)loadStructure {
    // Empty stub implementation.
}

- (void)reloadStructure {
    [self.table.sections removeAllObjects];
    [self loadStructure];
    [self.tableView reloadData];
}

- (void)buildTableWithBlock:(void (^)(id<PAYTableBuilder>))block {
    PAYFormTableBuilder *tableBuilder = [PAYFormTableBuilder new];
    tableBuilder.defaultBounds = CGRectMake(0, 0,
                                            self.view.frame.size.width,
                                            PAYFormTableViewControllerDefaultRowHeight);
    if (block) {
        block(tableBuilder);
    }
    self.table = tableBuilder.table;
    [self.table initSectionJumpOrder];
}

- (void)buildFooter {
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0,
                                  self.view.frame.size.width,
                                  PAYFormTableViewControllerDefaultFooterHeight);
    footerView.backgroundColor = UIColor.clearColor;
    
    self.tableView.tableFooterView = footerView;
}


#pragma mark - UITableViewDataSource's implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.table.sections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PAYFormSection *formSection = [self.table.sections objectAtIndex:section];
    return formSection.header.view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PAYFormSection *formSection = [self.table.sections objectAtIndex:section];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PAYFormSection *formSection = [self.table.sections objectAtIndex:section];
    return formSection.header.view.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *fieldView = [self formRowForIndexPath:indexPath].cell;
    return fieldView.frame.size.height;
}

#pragma mark - View management

- (id<PAYFormRow>)formRowForIndexPath:(NSIndexPath *)indexPath {
    PAYFormSection *section = [self.table.sections objectAtIndex:indexPath.section];
    id<PAYFormRow> formRow = [section.views objectAtIndex:indexPath.row];
    return formRow;
}


#pragma mark - PAYFormViewController's implementation

- (void)onDone:(id)sender {
    [self.table validate];
}

@end
