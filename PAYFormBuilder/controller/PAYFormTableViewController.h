//
//  PAYFormTableViewController.h
//  paij
//
//  Created by Simon Seyer on 29.10.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAYFormBuilder.h"


@interface PAYFormTableViewController : UITableViewController

@property (nonatomic, retain) PAYFormTable *table;


- (void)buildTableWithBlock:(void (^)(id<PAYTableBuilder>))block;

- (void)initForm;
- (void)loadStructure;
- (void)reloadStructure;
- (IBAction)onDone:(id)sender;

@end