//
//  PAYFormSectionBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSectionBuilder.h"
#import "PAYFormSectionBuilder_protected.h"
#import "PAYFormCellBuilder.h"
#import "PAYFormButtonGroup_protected.h"
#import "PAYFormButtonGroupBuilder_protected.h"

@implementation PAYFormSectionBuilder

- (id)initWithFormSection:(PAYFormSection *)section {
    self = [super init];
    if (self) {
        self.section = section;
    }
    return self;
}

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder {
    return [self addFieldWithPlaceholder:placeholder configureBlock:NULL];
}

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder
                                         configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    return [self addFieldWithName:nil placeholder:placeholder configureBlock:configureBlock];
}

- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name
                                     placeholder:(NSString *)placeholder {
    return [self addFieldWithName:name placeholder:placeholder configureBlock:NULL];
}

- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name
                                     placeholder:(NSString *)placeholder
                                  configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    PAYFormSingleLineTextField *formField = [PAYFormCellBuilder fieldWithName:name
                                                                  placeholder:placeholder
                                                               configureBlock:configureBlock];
    [self.section.views addObject:formField];
    return formField;
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder {
    return [self addTextViewWithPlaceholder:placeholder configureBlock:NULL];
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder
                                           configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    return [self addTextViewWithPlaceholder:placeholder adjustable:NO configureBlock:configureBlock];
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder
                                               adjustable:(BOOL)isAdjustable{
    return [self addTextViewWithPlaceholder:placeholder adjustable:isAdjustable configureBlock:NULL];
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder
                                               adjustable:(BOOL)isAdjustable
                                           configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    PAYFormMultiLineTextField *formField = [PAYFormCellBuilder textViewWithName:self.section.name
                                                                    placeholder:placeholder
                                                                     adjustable:isAdjustable
                                                                 configureBlock:configureBlock];
    [self.section.views addObject:formField];
    return formField;
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                        detailText:nil
                              icon:nil
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:nil];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                          detailText:(NSString *)detailText
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                        detailText:detailText
                              icon:nil
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:nil];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                                icon:(UIImage *)icon
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                        detailText:nil
                              icon:icon
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:nil];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                          detailText:detailText
                                icon:(UIImage *)icon
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                        detailText:detailText
                              icon:icon
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:nil];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                      configureBlock:(void(^)(PAYFormButton *))configureBlock {
    return [self addButtonWithText:text
                        detailText:nil
                              icon:nil
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:configureBlock];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                          detailText:(NSString *)detailText
                                icon:(UIImage *)icon
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                      configureBlock:(void(^)(PAYFormButton *))configureBlock {
    PAYFormButton *formView = [PAYFormCellBuilder buttonWithText:text
                                                      detailText:detailText
                                                            icon:icon
                                                           style:style
                                                  selectionBlock:selectionBlock
                                                  configureBlock:configureBlock];
    [self.section.views addObject:formView];
    return formView;
}

- (PAYFormButtonGroup *)addButtonGroupWithMultiSelection:(BOOL)multiSelection
                                            contentBlock:(void(^)(PAYFormButtonGroupBuilder *))contentBlock {
    PAYFormButtonGroup *buttonGroup = [PAYFormButtonGroup new];
    buttonGroup.multiSelection = multiSelection;
    buttonGroup.name = self.section.name;
    [self.section.attachedObjects addObject:buttonGroup];
    
    if (contentBlock) {
        PAYFormButtonGroupBuilder *buttonGroupBuilder = [PAYFormButtonGroupBuilder new];
        buttonGroupBuilder.buttonGroup    = buttonGroup;
        buttonGroupBuilder.sectionBuilder = self;
        contentBlock(buttonGroupBuilder);
    }
    
    return buttonGroup;
}

- (PAYFormSwitch *)addSwitchWithName:(NSString *)name {
    return [self addSwitchWithName:name configureBlock:nil];
}

- (PAYFormSwitch *)addSwitchWithName:(NSString *)name
                      configureBlock:(void(^)(PAYFormSwitch *))configureBlock {
    PAYFormSwitch *formView = [PAYFormCellBuilder switchWithName:name
                                                  configureBlock:configureBlock];
    [self.section.views addObject:formView];
    return formView;
}

- (void)addView:(void(^)(PAYFormView *))configureBlock {
    PAYFormView *formView = [PAYFormView new];
    formView.cell         = [PAYFormCellBuilder defaultCell];
    
    if (configureBlock) {
        configureBlock(formView);
    }
    
    [self.section.views addObject:formView];
}

@end
