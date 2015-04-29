//
//  PAYSectionBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormButton.h"
#import "PAYFormButtonGroupBuilder.h"

@class PAYFormSingleLineTextField;
@class PAYFormMultiLineTextField;
@class PAYFormButton;
@class PAYFormSwitch;
@class SZTextView;
@class PAYFormButtonGroup;

/**
 *  Builder class to create the different parts of a section.
 */
@interface PAYFormSectionBuilder : NSObject

#pragma mark - Add singleline textfields

/**
 *  Add a singleline textfield with a placeholder.
 *
 *  @param placeholder the text that should be displayed as placeholder
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder;

/**
 *  Add a singleline textfield with a placeholder and a block for customization.
 *
 *  @param placeholder the text that should be displayed as placeholder
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */

/**
 *  Add a singleline textfield with a placeholder and a block for customization.
 *
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param configureBlock a block that gets the preconfigurred PAYFormSingleLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

/**
 *  Add a singleline textfield with a placeholder and a label that is displayed in front of the textfield.
 *
 *  @param name        the text of the label that is displayed in front of the textfield
 *  @param placeholder the text that should be displayed as placeholder
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder;

/**
 *  Add a singleline textfield with a placeholder, a label that is displayed in front of the textfield
 *  and a block for customization.
 *
 *  @param name           the text of the label that is displayed in front of the textfield
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param configureBlock a block that gets the preconfigurred PAYFormSingleLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

#pragma mark - Add multiline textfields

/**
 *  Add a multiline textfield with a placeholder. It is normally used as the only element of a section where
 *  the section title describes the content the user should enter in.
 *
 *  @param placeholder the text that should be displayed as placeholder
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder;

/**
 *  Add a multiline textfield with a placeholder and a block for customization. It is normally used as the only element of a section where
 *  the section title describes the content the user should enter in.
 *
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param configureBlock a block that gets the preconfigurred PAYFormMultiLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

/**
 *  Add a multiline textfield with a placeholder and option for an adjustable height.
 *
 *
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param isAdjustable   boolean to set adjustability
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
*/
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder adjustable:(BOOL)isAdjustable;

/**
 *  Add a multiline textfield with a placeholder and option for an adjustable height and a block for customization.
 *
 *
 *  @param placeholder    the text that should be displayed as placeholder
 *  @param isAdjustable   boolean to set adjustability
 *  @param configureBlock a block that gets the preconfigurred PAYFormMultiLineTextField and
 *                        could modify it's parameters. It's for example used to set validators.
 *
 *  @return the model object of the textfield. It could be for example used to get the input, the user entered in the textfield.
 */
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder adjustable:(BOOL)isAdjustable configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

#pragma mark - Add buttons

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param detailText     the text that should be displayed as detail information
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text detailText:(NSString *)detailText style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param icon           the icon that should be displaced in the button
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text icon:(UIImage *)icon style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param detailText     the text that should be displayed as detail information
 *  @param icon           the icon that should be displaced in the button
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text detailText:detailText icon:(UIImage *)icon style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *  @param configureBlock a block that gets the preconfigurred PAYFormButton and
 *                        could modify it's parameters
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock;

/**
 *  Add a configured button
 *
 *  @param text           the text that should be displayed on the button
 *  @param detailText     the text that should be displayed as detail information
 *  @param icon           the icon that should be displaced in the button
 *  @param style          the style that determines the appearance of the button
 *  @param selectionBlock the block that is called when the user touched the button.
 *                        The corresponding PAYFormButton is passed.
 *  @param configureBlock a block that gets the preconfigurred PAYFormButton and
 *                        could modify it's parameters
 *
 *  @return the model object of the button
 */
- (PAYFormButton *)addButtonWithText:(NSString *)text detailText:(NSString *)detailText icon:(UIImage *)icon style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock;

/**
 *  Add button-group that could be used as single- or multi-selection list. 
 *  For the name of the group the name of the section is used.
 *
 *  @param multiSelection true, if multiple buttons could be selected at one time.
 *  @param contentBlock   the block to configure the content of the button group.
 *                        A PAYButtonGroupBuilder is passed to accomplish this.
 *
 *  @return the model object of the button group. I's for example used to get the values the user selected
 */
- (PAYFormButtonGroup *)addButtonGroupWithMultiSelection:(BOOL)multiSelection contentBlock:(void(^)(PAYFormButtonGroupBuilder *))contentBlock;

#pragma mark - Add switches

/**
 *  Add a toggle switch with a label.
 *
 *  @param name the text of the label that is displayed in front of the switch
 *
 *  @return the model object of the switch. It's for example used to get the value the used selected.
 */
- (PAYFormSwitch *)addSwitchWithName:(NSString *)name;

/**
 *  Add a toggle switch with a label and a customization block.
 *
 *  @param name           the text of the label that is displayed in front of the switch
 *  @param configureBlock a block that gets the preconfigurred PAYFormSwitch and
 *                        could modify it's parameters

 *
 *  @return the model object of the switch. It's for example used to get the value the used selected.
 */
- (PAYFormSwitch *)addSwitchWithName:(NSString *)name configureBlock:(void(^)(PAYFormSwitch *))configureBlock;

#pragma mark - Add generic views

/**
 *  Add a generic view that could be used to display custom views.
 *
 *  @param configureBlock a block that gets the preconfigurred PAYFormView and
 *                        could modify it's parameters. The custom content has to be added to the view property.
 */
- (void)addView:(void(^)(PAYFormView *))configureBlock;

@end
