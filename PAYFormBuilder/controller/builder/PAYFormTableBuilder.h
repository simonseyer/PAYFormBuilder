//
//  PAYTableBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSectionBuilder.h"
#import "PAYFormSection.h"
#import "PAYTextLabel.h"
#import "PAYFormTable.h"

/**
 *  Builder class to create the sections of a form table.
 */
@interface PAYFormTableBuilder : NSObject

/**
 *  If the first textfield should be selected, when the form becomes visisble
 */
@property (nonatomic, assign) BOOL selectFirstField;

/**
 *  If the validation of the form should be triggered, when the user
 *  finishes the last textfield with the appropriate button on the keyboard.
 */
@property (nonatomic, assign) BOOL finishOnLastField;

/**
 *  Is called, when the form is submitted and all other validations are succeeded.
 *  Should return an error, when there is something wrong in the form or nil, if everything
 *  is fine.
 */
@property (nonatomic, copy) PAYFormValidationBlock validationBlock;

/**
 *  Is called, when the form is submitted and all validations, including the
 *  validationBlock of the whole table, are succeeded.
 */
@property (nonatomic, copy) PAYFormTableSuccessBlock formSuccessBlock;

/**
 *  Is called, when a validation blocks returns an error. It should present
 *  the error to the user so he could fix it.
 */
@property (nonatomic, copy) PAYFormTableFailBlock formFailBlock;

#pragma mark - Add sections

/**
 *  Add a new section to the table. The section is displayed without a section header.
 *  The PAYFormTableLabelStyleEmpty is used as label style (determines the section height).
 *
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithContentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table without a section header label but with a custom section label style.
 *  The style also determines the height of the header.
 *
 *  @param style        the style of the label that is displayed above the section
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithLabelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)( PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table with a custom header.
 *
 *  @param headerBlock  the block to configure the header of the section.
 *                      A preconfigured PAYFormHeader is passed, that could be personalized.
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table with a section header label and the default label style PAYFormTableLabelStyleSimple.
 *
 *  @param name         the text that should be visible above the section
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithName:(NSString *)name contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table with a section header label and the default label style PAYFormTableLabelStyleSimple.
 *
 *  @param name         the text that should be visible above the section
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 *  @param infoBlock    the block that is called when the user pushes the info icon of the section.
 *                      The info icon is only shown, if this block is set.
 */
- (void)addSectionWithName:(NSString *)name contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock infoBlock:(void(^)(UIButton *))infoBlock;

/**
 *  Add a new section to the table with a section header label and a custom label style.
 *
 *  @param name         the text that should be visible above the section
 *  @param style        the style of the label that is displayed above the section
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table with a section header label and a custom label style.
 *
 *  @param name         the text that should be visible above the section
 *  @param style        the style of the label that is displayed above the section
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 *  @param infoBlock    the block that is called when the user pushes the info icon of the section.
 *                      The info icon is only shown, if this block is set.
 */
- (void)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock infoBlock:(void(^)(UIButton *))infoBlock;

/**
 *  Add a new section to the table with a section header label, a custom label style as default and a custom header.
 *
 *  @param name         the text that should be visible above the section
 *  @param style        the style of the label that is displayed above the section. 
 *                      Could be changed in the header block.
 *  @param headerBlock  the block to configure the header of the section.
 *                      A preconfigured PAYFormHeader is passed, that could be personalized.
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 */
- (void)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style headerBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock;

/**
 *  Add a new section to the table with a section header label, a custom label style as default and a custom header.
 *
 *  @param name         the text that should be visible above the section
 *  @param style        the style of the label that is displayed above the section.
 *                      Could be changed in the header block.
 *  @param headerBlock  the block to configure the header of the section.
 *                      A preconfigured PAYFormHeader is passed, that could be personalized.
 *  @param contentBlock the block to configure the content of the section.
 *                      A SectionBuilder is passed to accomplish this.
 *  @param infoBlock    the block that is called when the user pushes the info icon of the section.
 *                      The info icon is only shown, if this block is set.
 */
- (void)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style headerBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock infoBlock:(void(^)(UIButton *))infoBlock;

/**
 *  Create a form header with a name, a style and an info block
 *
 *  @param name         the text that should be visible above the section
 *  @param style        the style of the label that is displayed above the section.
 *                      Could be changed in the header block.
 *  @param infoBlock    the block that is called when the user pushes the info icon of the section.
 *                      The info icon is only shown, if this block is set.
 */
+ (PAYFormHeader *)headerViewWithStyle:(PAYFormTableLabelStyle)style name:(NSString *)name infoBlock:(void (^)(UIButton *))infoBlock;

@end
