//
//  PAYFormTableViewController.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 29.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAYTableBuilder;

@class PAYFormTable;

@interface PAYFormTableViewController : UITableViewController

@property (nonatomic, assign) CGFloat defaultRowHeight    UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat defaultFooterHeight UI_APPEARANCE_SELECTOR;


@property (nonatomic, retain) PAYFormTable *table;

- (void)initForm;
- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder;
- (void)reloadStructure;
- (IBAction)onDone:(id)sender;

@end