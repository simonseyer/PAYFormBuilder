//
//  PAYFormSectionBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSectionBuilder.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormSingleLineTextField_protected.h"
#import "PAYFormMultiLineTextField.h"
#import "PAYFormMultiLineTextField_protected.h"
#import "PAYFormButton.h"
#import "PAYFormButton_protected.h"
#import "PAYFormView.h"
#import "PAYFormButtonGroup.h"
#import "PAYFormButtonGroup_protected.h"
#import "PAYFormButtonGroupBuilder.h"
#import "PAYFormSwitch.h"
#import "PAYFormSwitch_protected.h"
#import "UIColor+PAYHex.h"
#import "PAYButtonGroupBuilder.h"
#import "PAYFormView_protected.h"


@implementation PAYFormSectionBuilder

- (id)initWithFormSection:(PAYFormSection *)section
        defaultCellBounds:(CGRect)defaultBounds {
    self = [super init];
    if (self) {
        self.section = section;
        self.defaultBounds = defaultBounds;
        
        self.defaultHorzMargin              = 14.0f;
        self.defaultLabelWidth              = 91.0f;
        self.defaultLabelFieldSpace         = 6.0f;
        self.defaultDisclosureLeftMargin    = 21.0f;
        self.defaultDisclosureRightMargin   = 28.0f;
        self.defaultIconSize                = 21.0f;
        self.defaultIconMargin              = 17.0f;
        self.defaultLeftIconMargin          = 59.0f;
        self.defaultFontSize                = 17.0f;
        self.defaultTextViewLineCount       = 3;
        self.defaultTextColor               = [UIColor colorFromHex:0xFF323232];
        self.defaultPlaceholderColor        = [UIColor colorFromHex:0xFFCACACA];
        self.defaultButtonPrimaryTextColor  = [UIColor colorFromHex:0xFF214889];
        self.defaultButtonHilightTextColor  = [UIColor colorFromHex:0xFFE87E18];
        self.defaultButtonDisabledTextColor = [UIColor colorFromHex:0xFF898989];
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
    UILabel *label = nil;
    CGFloat leftFieldMargin = self.defaultHorzMargin;
    if (name) {
        label           = [self defaultLabelInRect:self.defaultBounds];
        label.text      = name;
        leftFieldMargin = CGRectGetMaxX(label.frame) + self.defaultLabelFieldSpace;
    }
    
    UITextField *textField    = [self defaultTextField];
    textField.placeholder     = placeholder;

    CGRect expandedFieldFrame = CGRectInset(self.defaultBounds, self.defaultHorzMargin, 0);
    CGRect fieldFrame         = self.defaultBounds;
    fieldFrame.origin.x       = leftFieldMargin;
    fieldFrame.size.width    -= (fieldFrame.origin.x + self.defaultHorzMargin);
    textField.frame           = fieldFrame;
    
    UITableViewCell *cell = self.defaultCell;
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
    labelFrame.origin.x   = self.defaultHorzMargin;
    labelFrame.size.width = self.defaultLabelWidth;
    label.frame           = labelFrame;
    label.font            = [UIFont fontWithName:label.font.fontName
                                            size:self.defaultFontSize];
    label.textColor       = self.defaultTextColor;
    
    return label;
}

- (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font            = [UIFont fontWithName:textField.font.fontName
                                                size:self.defaultFontSize];
    return textField;
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder {
    return [self addTextViewWithPlaceholder:placeholder configureBlock:NULL];
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder
                                           configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    SZTextView *textView            = self.defaultTextView;
    textView.placeholder            = placeholder;
    textView.placeholderTextColor   = self.defaultPlaceholderColor;
    
    CGRect textViewFrame      = self.defaultBounds;
    // Two line heights for top and bottom contentInset
    textViewFrame.size.height = textView.font.lineHeight * (2 + self.defaultTextViewLineCount);
    textView.frame            = textViewFrame;
    
    UITableViewCell *cell = self.defaultCell;
    cell.frame            = textViewFrame;
    [cell addSubview:textView];

    PAYFormMultiLineTextField *formField = [PAYFormMultiLineTextField new];
    formField.view     = cell;
    formField.textView = textView;
    formField.name     = self.section.name;
    
    if(configureBlock){
        configureBlock(formField);
    }
    
    [self.section.views addObject:formField];
    
    return formField;
}

- (SZTextView *)defaultTextView {
    SZTextView *textView        = [SZTextView new];
    textView.font               = [UIFont fontWithName:textView.font.fontName
                                                  size:self.defaultFontSize];
    textView.textContainerInset = UIEdgeInsetsMake(textView.font.lineHeight, self.defaultHorzMargin,
                                                   textView.font.lineHeight, self.defaultHorzMargin);
    return textView;
}

- (PAYFormButton *)addButtonWithText:(NSString *)text
                               style:(PAYFormButtonStyle)style
                      selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    return [self addButtonWithText:text style:style selectionBlock:selectionBlock configureBlock:NULL];
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
        cell.separatorInset = UIEdgeInsetsMake(0, self.defaultLeftIconMargin, 0, 0);
    }
    
    UILabel *titleLabel;
    if (style != PAYFormButtonStyleEmpty) {
        titleLabel      = [UILabel new];
        titleLabel.text = text;
        titleLabel.font = [UIFont fontWithName:titleLabel.font.fontName
                                          size:self.defaultFontSize];
        titleLabel.userInteractionEnabled = NO;
        
        if (style == PAYFormButtonStylePrimaryCentered) {
            titleLabel.textColor = self.defaultButtonPrimaryTextColor;
        } else if (style == PAYFormButtonStyleHilightedCentered) {
            titleLabel.textColor = self.defaultButtonHilightTextColor;
        } else if (style == PAYFormButtonStyleDisabledCentered) {
            titleLabel.textColor = self.defaultButtonDisabledTextColor;
        } else {
            titleLabel.textColor = self.defaultTextColor;
        }
        
        CGRect labelFrame = self.defaultBounds;
        if (style == PAYFormButtonStyleDisclosure) {
            labelFrame.origin.x      = self.defaultDisclosureLeftMargin;
            labelFrame.size.width   -= self.defaultDisclosureLeftMargin +
                                       self.defaultDisclosureRightMargin;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else if(style == PAYFormButtonStyleSelection) {
            labelFrame.origin.x      = self.defaultHorzMargin;
            labelFrame.size.width   -= self.defaultHorzMargin +
                                       self.defaultDisclosureRightMargin;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
            labelFrame.origin.x      = self.defaultLeftIconMargin;
            labelFrame.size.width   -= self.defaultLeftIconMargin +
                                       self.defaultDisclosureRightMargin;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else {
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        titleLabel.frame = labelFrame;
        
        [cell addSubview:titleLabel];
    }
        
    UIImageView *iconView;
    if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
        iconView = [UIImageView new];
        
        CGRect iconFrame = self.defaultBounds;
        iconFrame.size = CGSizeMake(self.defaultIconSize,
                                    self.defaultIconSize);
        iconFrame.origin.x = self.defaultIconMargin;
        iconFrame.origin.y = (self.defaultBounds.size.height - iconFrame.size.height) / 2.0f;
        iconView.frame = iconFrame;
        
        [cell addSubview:iconView];
    }
    
    PAYFormButton *formButton  = [PAYFormButton new];
    formButton.view           = cell;
    formButton.titleLabel     = titleLabel;
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
                                            contentBlock:(void(^)(id<PAYButtonGroupBuilder>))contentBlock {
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
    
    UISwitch *switchControl   = [UISwitch new];
    
    CGRect switchFrame     = switchControl.frame;
    switchFrame.origin.x   = self.defaultBounds.size.width -
                             switchFrame.size.width - self.defaultHorzMargin;
    switchFrame.origin.y   = (self.defaultBounds.size.height - switchFrame.size.height) / 2.0f;
    switchControl.frame    = switchFrame;
    
    CGRect labelFrame = label.frame;
    labelFrame.size.width  = switchFrame.origin.x;
    labelFrame.size.width -= labelFrame.origin.x + self.defaultHorzMargin;
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
