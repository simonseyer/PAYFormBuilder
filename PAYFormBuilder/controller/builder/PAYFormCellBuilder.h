//
//  PAYFormCellBuilder.h
//  Pods
//
//  Created by COBI on 13.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SZTextView/SZTextView.h>
#import "PAYFormSingleLineTextField.h"
#import "PAYFormMultiLineTextField.h"
#import "PAYFormButton.h"
#import "PAYFormSwitch.h"

/**
 *  Builder class to create the content of the cells.
 */
@interface PAYFormCellBuilder : NSObject

/**
 *  Create a singleline textfield with a placeholder, a label that is displayed in front of the textfield
 *  and a block for customization.
 *
 *  @param name           the text of the label that is displayed in front of the textfield
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param inBounds       the bounds the field should be layouted in
 *  @param configureBlock a block that gets the preconfigurred PAYFormSingleLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return a container for the textfield
 */
+ (PAYFormSingleLineTextField *)fieldWithName:(NSString *)name
                                  placeholder:(NSString *)placeholder
                                     inBounds:(CGRect)bounds
                               configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

/**
 *  Crate a multiline textfield with a placeholder and option for an adjustable height and a block for customization.
 *
 *  @param name           the name that is used in validation
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param inBounds       the bounds the field should be layouted in
 *  @param isAdjustable   boolean to set adjustability
 *  @param configureBlock a block that gets the preconfigurred PAYFormMultiLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return a container for the textview
 */
+ (PAYFormMultiLineTextField *)textViewWithName:(NSString *)name
                                    placeholder:(NSString *)placeholder
                                       inBounds:(CGRect)bounds
                                     adjustable:(BOOL)isAdjustable
                                 configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

/**
 *  Create a button with a text, a customization block and a block that is called, when the user pressed the button.
 *
 *  @param text           the text that should be displayed on the button
 *  @param detailText     the text that should be display as detail information
 *  @param style          the style that determines the appearance of the button
 *  @param inBounds       the bounds the field should be layouted in
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *  @param configureBlock a block that gets the preconfigurred PAYFormButton and
 *                        could modify it's parameters
 *
 *  @return a container for the button
 */
+ (PAYFormButton *)buttonWithText:(NSString *)text
                       detailText:(NSString *)detailText
                            style:(PAYFormButtonStyle)style
                         inBounds:(CGRect)bounds
                   selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                   configureBlock:(void(^)(PAYFormButton *))configureBlock;

/**
 *  Create a toggle switch with a label and a customization block.
 *
 *  @param name           the text of the label that is displayed in front of the switch
 *  @param inBounds       the bounds the field should be layouted in
 *  @param configureBlock a block that gets the preconfigurred PAYFormSwitch and
 *                        could modify it's parameters
 
 *
 *  @return a container for the switch
 */
+ (PAYFormSwitch *)switchWithName:(NSString *)name
                         inBounds:(CGRect)bounds
                   configureBlock:(void(^)(PAYFormSwitch *))configureBlock;

/**
 *  Get a label that is configured with the default parameters of the section.
 *
 *  @param bounds the bounds the label should be configured with
 *
 *  @return the preconfigured cell
 */
+ (UITableViewCell *)defaultCellInBounds:(CGRect)bounds;

/**
 *  Get a label that is configured with the default parameters of the section.
 *
 *  @param bounds the bounds the label should be configured with
 *
 *  @return the preconfigured label
 */
+ (UILabel *)defaultLabelInBounds:(CGRect)bounds;

/**
 *  Get a configured textfield
 *
 *  @return the preconfigured textfield
 */
+ (UITextField *)defaultTextField;

/**
 *  Get a configured textview
 *
 *  @return the preconfigured textview
 */
+ (SZTextView *)defaultTextView;


@end
