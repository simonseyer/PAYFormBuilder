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

/**
 *  The table view controller that displays the form. 
 *  It should be subclassed and configured in the loadStructure.
 */
@interface PAYFormTableViewController : UITableViewController

/**
 *  The default height of each row
 */
@property (nonatomic, assign) CGFloat defaultRowHeight UI_APPEARANCE_SELECTOR;

/**
 *  The default height of the table footer
 */
@property (nonatomic, assign) CGFloat defaultFooterHeight UI_APPEARANCE_SELECTOR;

/**
 *  This method could be overriden by the subclass to configure the form table view controller. 
 *  For example a custom footer could be set. This is method is only called once after the view 
 *  controller is set up and before loadStructure is called.
 */
- (void)initForm;

/**
 *  This method has to be overwritten. Here the complete form is configured.
 *  The method is called once after the view controller is set up and
 *  every time the reload strucutre method is called.
 *
 *  @param tableBuilder the builder class to create the form
 */
- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder;

/**
 *  Clears the complete form and calls loadStructure again.
 */
- (void)reloadStructure;

/**
 *  This action could be used to submit the form.
 *
 *  @param sender the component that sended the action
 */
- (IBAction)onDone:(id)sender;

@end