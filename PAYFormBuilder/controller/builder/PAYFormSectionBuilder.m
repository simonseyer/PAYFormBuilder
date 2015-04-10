//
//  PAYFormSectionBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSectionBuilder.h"
#import "PAYFormSectionBuilder_protected.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormSingleLineTextField_protected.h"
#import "PAYFormMultiLineTextField.h"
#import "PAYFormMultiLineTextField_protected.h"
#import "PAYFormButton.h"
#import "PAYFormButton_protected.h"
#import "PAYFormView.h"
#import "PAYFormButtonGroup.h"
#import "PAYFormButtonGroup_protected.h"
#import "PAYFormButtonGroupBuilder_protected.h"
#import "PAYFormSwitch.h"
#import "PAYFormSwitch_protected.h"
#import "UIColor+PAYHex.h"
#import "PAYFormButtonGroupBuilder.h"
#import "PAYFormView_protected.h"
#import <SZTextView/SZTextView.h>
#import "PAYStyle.h"
#import "PAYSwitch.h"

@implementation PAYFormSectionBuilder

- (id)initWithFormSection:(PAYFormSection *)section
        defaultCellBounds:(CGRect)defaultBounds {
    self = [super init];
    if (self) {
        self.section = section;
        self.defaultBounds = defaultBounds;
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
    UITextField *textField    = [self defaultTextField];
    textField.placeholder     = placeholder;
    
    UILabel *label = nil;
    CGFloat leftFieldMargin = PAYStyle.sectionTheme.horizontalMargin;
    if (name) {
        label           = [self defaultLabelInRect:self.defaultBounds];
        label.text      = name;
        leftFieldMargin = CGRectGetMaxX(label.frame) + PAYStyle.sectionTheme.labelFieldSpacing;
        if (textField.textAlignment == NSTextAlignmentRight) {
            CGRect labelRect = label.frame;
            labelRect.size.width = self.defaultBounds.size.width - 2 * PAYStyle.sectionTheme.horizontalMargin;
            label.frame = labelRect;
        }
    }

    CGRect expandedFieldFrame = CGRectInset(self.defaultBounds, PAYStyle.sectionTheme.horizontalMargin, 0);
    CGRect fieldFrame         = self.defaultBounds;
    fieldFrame.origin.x       = leftFieldMargin;
    fieldFrame.size.width    -= (fieldFrame.origin.x + PAYStyle.sectionTheme.horizontalMargin);
    textField.frame           = fieldFrame;
    
    UITableViewCell *cell = self.defaultCell;
    cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
    [cell addSubview:label];
    [cell addSubview:textField];
    
    PAYFormSingleLineTextField *formField = [PAYFormSingleLineTextField new];
    formField.view          = cell;
    formField.label         = label;
    formField.textField     = textField;
    formField.defaultFrame  = textField.frame;
    formField.expandedFrame = expandedFieldFrame;
    
    if (configureBlock) {
        configureBlock(formField);
    }
    
    [self.section.views addObject:formField];
    
    return formField;
}

- (UILabel *)defaultLabelInRect:(CGRect)defaultBounds {
    UILabel *label = [UILabel new];
    CGRect labelFrame     = defaultBounds;
    labelFrame.origin.x   = PAYStyle.sectionTheme.horizontalMargin;
    labelFrame.size.width = PAYStyle.sectionTheme.labelWidth;
    label.frame           = labelFrame;
    label.font            = PAYStyle.theme.font;
    label.textColor       = PAYStyle.sectionTheme.textColor;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
}

- (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textAlignment   = PAYStyle.sectionTheme.fieldTextAlignment;
    textField.font            = PAYStyle.theme.font;
    return textField;
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
    SZTextView *textView            = self.defaultTextView;
    textView.font                   = PAYStyle.theme.font;
    textView.placeholderTextColor   = PAYStyle.sectionTheme.placeholderColor;
    if (placeholder) {
        textView.placeholder            = placeholder;
    }
    
    CGRect textViewFrame      = self.defaultBounds;
    // Two line heights for top and bottom contentInset
    if (isAdjustable) {
        textViewFrame.size.height = textView.font.lineHeight * PAYStyle.sectionTheme.textViewLineCount;
    }else {
        textViewFrame.size.height = textView.font.lineHeight * (2 + PAYStyle.sectionTheme.textViewLineCount);
    }
    textView.frame            = textViewFrame;
    
    UITableViewCell *cell = self.defaultCell;
    cell.frame            = textViewFrame;
    [cell addSubview:textView];
    
    PAYFormMultiLineTextField *formField = [PAYFormMultiLineTextField new];
    formField.view     = cell;
    formField.textView = textView;
    formField.name     = self.section.name;
    formField.isAdjustable = isAdjustable;
    formField.textView.scrollEnabled = !isAdjustable;
    
    if (configureBlock) {
        configureBlock(formField);
    }
    [self.section.views addObject:formField];
    return formField;
}

- (SZTextView *)defaultTextView {
    SZTextView *textView        = [SZTextView new];
    textView.font               = PAYStyle.theme.font;
    textView.textContainerInset = UIEdgeInsetsMake(textView.font.lineHeight, PAYStyle.sectionTheme.horizontalMargin,
                                                   textView.font.lineHeight, PAYStyle.sectionTheme.horizontalMargin);
    return textView;
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text style:style selectionBlock:selectionBlock configureBlock:NULL];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                          detailText:(NSString *)detailText
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                        detailText:detailText
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:nil];
}


- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                                icon:(UIImage *)icon
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:^(PAYFormButton *formButton) {
                        formButton.iconView.image = icon;
    }];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                      configureBlock:(void(^)(PAYFormButton *))configureBlock {
    return [self addButtonWithText:text
                        detailText:nil
                             style:style
                    selectionBlock:selectionBlock
                    configureBlock:configureBlock];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                          detailText:(NSString *)detailText
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                      configureBlock:(void(^)(PAYFormButton *))configureBlock {
    UITableViewCell *cell = self.defaultCell;
    
    if (style == PAYFormButtonStyleDisabledCentered) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (style == PAYFormButtonStyleDisclosure || style == PAYFormButtonStyleIconDisclosure) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
        cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.iconMarginLeft, 0, 0);
    } else {
        cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
    }
    
    UILabel *titleLabel;
    UILabel *detailLabel;
    if (style != PAYFormButtonStyleEmpty) {
        titleLabel      = [UILabel new];
        titleLabel.text = text;
        titleLabel.font = PAYStyle.theme.font;
        titleLabel.userInteractionEnabled = NO;
        
        if (style == PAYFormButtonStylePrimaryCentered) {
            titleLabel.textColor = PAYStyle.sectionTheme.buttonPrimaryTextColor;
        } else if (style == PAYFormButtonStyleHilightedCentered) {
            titleLabel.textColor = PAYStyle.sectionTheme.buttonHilightTextColor;
        } else if (style == PAYFormButtonStyleDisabledCentered) {
            titleLabel.textColor = PAYStyle.sectionTheme.buttonDisabledTextColor;
        } else {
            titleLabel.textColor = PAYStyle.sectionTheme.textColor;
        }
        
        CGRect labelFrame = self.defaultBounds;
        if (style == PAYFormButtonStyleDisclosure || style == PAYFormButtonStyleSelection) {
            labelFrame.origin.x      = PAYStyle.sectionTheme.horizontalMargin;
            labelFrame.size.width   -= PAYStyle.sectionTheme.horizontalMargin +
                                       PAYStyle.sectionTheme.disclosureMarginRight;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
            labelFrame.origin.x      = PAYStyle.sectionTheme.iconMarginLeft;
            labelFrame.size.width   -= PAYStyle.sectionTheme.iconMarginLeft +
                                       PAYStyle.sectionTheme.disclosureMarginRight;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else {
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        titleLabel.frame = labelFrame;
        
        [cell addSubview:titleLabel];
        
        if (detailText) {
            detailLabel = [UILabel new];
            detailLabel.text = detailText;
            detailLabel.font = titleLabel.font;
            detailLabel.textColor = PAYStyle.sectionTheme.buttonDetailTextColor;
            detailLabel.textAlignment = NSTextAlignmentRight;
         
            CGRect labelFrame = self.defaultBounds;
            if (style == PAYFormButtonStyleDisclosure ||
                style == PAYFormButtonStyleIconDisclosure ||
                style == PAYFormButtonStyleSelection ||
                style == PAYFormButtonStyleIconSelection) {
                labelFrame.size.width -= PAYStyle.sectionTheme.disclosureMarginRight;
            } else {
                labelFrame.size.width -= PAYStyle.sectionTheme.horizontalMargin;
            }
            detailLabel.frame = labelFrame;
            
            [cell addSubview:detailLabel];
        }
    }
        
    UIImageView *iconView;
    if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
        iconView = [UIImageView new];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGRect iconFrame = self.defaultBounds;
        iconFrame.size = CGSizeMake(PAYStyle.sectionTheme.iconSize,
                                    PAYStyle.sectionTheme.iconSize);
        iconFrame.origin.x = PAYStyle.sectionTheme.iconMargin;
        iconFrame.origin.y = (self.defaultBounds.size.height - iconFrame.size.height) / 2.0f;
        iconView.frame = iconFrame;
        
        [cell addSubview:iconView];
    }
    
    PAYFormButton *formButton  = [PAYFormButton new];
    formButton.view           = cell;
    formButton.titleLabel     = titleLabel;
    formButton.detailLabel    = detailLabel;
    formButton.style          = style;
    formButton.iconView       = iconView;
    formButton.selectionBlock = selectionBlock;
    
    if (configureBlock){
        configureBlock(formButton);
    }
    
    [self.section.views addObject:formButton];
    
    return formButton;
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
    UILabel *label = [self defaultLabelInRect:self.defaultBounds];
    label.text     = name;
    
    UISwitch *switchControl   = [PAYSwitch new];
    
    CGRect switchFrame     = switchControl.frame;
    switchFrame.origin.x   = self.defaultBounds.size.width -
                             switchFrame.size.width - PAYStyle.sectionTheme.horizontalMargin;
    switchFrame.origin.y   = (self.defaultBounds.size.height - switchFrame.size.height) / 2.0f;
    switchControl.frame    = switchFrame;
    
    CGRect labelFrame = label.frame;
    labelFrame.size.width  = switchFrame.origin.x;
    labelFrame.size.width -= labelFrame.origin.x + PAYStyle.sectionTheme.horizontalMargin;
    label.frame = labelFrame;
    
    UITableViewCell *cell = self.defaultCell;
    [cell addSubview:label];
    [cell addSubview:switchControl];
    
    PAYFormSwitch *formSwitch = [PAYFormSwitch new];
    formSwitch.view          = cell;
    formSwitch.label         = label;
    formSwitch.switchControl = switchControl;
    
    if (configureBlock) {
        configureBlock(formSwitch);
    }
    
    [self.section.views addObject:formSwitch];
    
    return formSwitch;
    
}

- (void)addView:(void(^)(PAYFormView *))configureBlock {
    PAYFormView *formView = [PAYFormView new];
    formView.view        = self.defaultCell;
    
    if (configureBlock) {
        configureBlock(formView);
    }
    
    [self.section.views addObject:formView];
}

- (UITableViewCell *)defaultCell {
    UITableViewCell *cell = [UITableViewCell new];
    cell.frame            = self.defaultBounds;
    cell.backgroundColor  = UIColor.whiteColor;
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
