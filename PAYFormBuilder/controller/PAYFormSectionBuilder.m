//
//  PAYFormSectionBuilder.m
//  paij
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormSectionBuilder.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormMultiLineTextField.h"
#import "PAYFormButton.h"
#import "PAYFormView.h"


@implementation PAYFormSectionBuilder

- (id)initWithFormSection:(PAYFormSection *)section defaultCellBounds:(CGRect)defaultBounds {
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

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    UITextField *textField = [PAYFormSectionBuilder defaultTextField];
    textField.placeholder  = placeholder;
    
    CGRect fieldFrame     = self.defaultBounds;
    fieldFrame.origin.x   = 14;
    fieldFrame.size.width = self.defaultBounds.size.width - 28;
    textField.frame       = fieldFrame;
    
    UITableViewCell *cell = self.defaultCell;
    [cell addSubview:textField];
    
    PAYFormSingleLineTextField *formField = [PAYFormSingleLineTextField new];
    formField.section      = self.section;
    formField.cell         = cell;
    formField.textField    = textField;
    
    if (configureBlock) {
        configureBlock(formField);
    }
    
    [self.section.views addObject:formField];
    
    return formField;
}

- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder {
    return [self addFieldWithName:name placeholder:placeholder configureBlock:NULL];
}

- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    UILabel *label = [PAYFormSectionBuilder defaultLabelInRect:self.defaultBounds];
    label.text     = name;
    
    CGFloat horizontalSpacing = 14;
    UITextField *textField    = [PAYFormSectionBuilder defaultTextField];
    textField.placeholder     = placeholder;

    CGRect fieldFrame     = self.defaultBounds;
    fieldFrame.origin.x   = CGRectGetMaxX(label.frame) + 6;
    fieldFrame.size.width = self.defaultBounds.size.width - fieldFrame.origin.x - horizontalSpacing;
    textField.frame       = fieldFrame;
    
    UITableViewCell *cell = self.defaultCell;
    [cell addSubview:label];
    [cell addSubview:textField];
    
    PAYFormSingleLineTextField *formField = [PAYFormSingleLineTextField new];
    formField.section      = self.section;
    formField.cell         = cell;
    formField.label        = label;
    formField.textField    = textField;
    
    if (configureBlock) {
        configureBlock(formField);
    }
    
    [self.section.views addObject:formField];
    
    return formField;
}

+ (UILabel *)defaultLabelInRect:(CGRect)defaultBounds {
    UILabel *label = [UILabel new];
    CGRect labelFrame     = defaultBounds;
    labelFrame.origin.x   = 14;
    labelFrame.size.width = 91;
    label.frame           = labelFrame;
    label.font            = [UIFont fontWithName:label.font.fontName size:17];
    label.textColor       = [UIColor colorFromHex:0xFF323232];
    
    return label;
}

+ (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font            = [UIFont fontWithName:textField.font.fontName size:17];
    return textField;
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder {
    return [self addTextViewWithPlaceholder:placeholder configureBlock:NULL];
}

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    UITextView *textView            = [PAYFormSectionBuilder defaultTextView];
    //textView.placeholder            = placeholder; TODO
    
    CGRect textViewFrame      = self.defaultBounds;
    textViewFrame.size.height = textView.font.lineHeight * (2 + 3);// Two line heights for top and bottom contentInset
    textView.frame            = textViewFrame;
    
    UITableViewCell *cell = self.defaultCell;
    cell.frame            = textViewFrame;
    [cell addSubview:textView];

    PAYFormMultiLineTextField *formField = [PAYFormMultiLineTextField new];
    formField.section                   = self.section;
    formField.cell                      = cell;
    formField.textView                  = textView;
    
    if(configureBlock){
        configureBlock(formField);
    }
    
    [self.section.views addObject:formField];
    
    return formField;
}

+ (UITextView *)defaultTextView {
    UITextView *textView            = [UITextView new];
    textView.font                   = [UIFont fontWithName:textView.font.fontName size:17];
    textView.textContainerInset     = UIEdgeInsetsMake(textView.font.lineHeight, 14, textView.font.lineHeight, 14);
    return textView;
}

- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormSelectionBlock)selectionBlock {
    return [self addButtonWithText:text style:style selectionBlock:selectionBlock configureBlock:NULL];
}

- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock {
    UITableViewCell *cell = self.defaultCell;
    cell.accessoryType    = UITableViewCellAccessoryNone;
    
    if (style == PAYFormButtonStyleDisabledCentered) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (style == PAYFormButtonStyleDisclosure || style == PAYFormButtonStyleIconDisclosure) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
        cell.separatorInset = UIEdgeInsetsMake(0, 59, 0, 0);
    }
    
    UILabel *titleLabel;
    if (style != PAYFormButtonStyleEmpty) {
        titleLabel = [UILabel new];
        titleLabel.text = text;
        titleLabel.font = [UIFont fontWithName:titleLabel.font.fontName size:17];
        titleLabel.userInteractionEnabled = NO;
        
        if (style == PAYFormButtonStylePrimaryCentered) {
            titleLabel.textColor = [UIColor colorFromHex:0xFF214889];
        } else if (style == PAYFormButtonStyleHilightedCentered) {
            titleLabel.textColor = [UIColor colorFromHex:0xFFE87E18];
        } else {
            titleLabel.textColor = [UIColor colorFromHex:0xFF323232];
        }
        
        CGRect labelFrame = self.defaultBounds;
        if (style == PAYFormButtonStyleDisclosure) {
            labelFrame.origin.x      = 21;
            labelFrame.size.width   -= 21;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else if(style == PAYFormButtonStyleSelection) {
            labelFrame.origin.x      = 14;
            labelFrame.size.width   -= 14;
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else if (style == PAYFormButtonStyleIconDisclosure || style == PAYFormButtonStyleIconSelection) {
            labelFrame.origin.x      = 59;
            labelFrame.size.width   -= 59;
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
        iconFrame.size = CGSizeMake(21, 21);
        iconFrame.origin.x = 17;
        iconFrame.origin.y = (self.defaultBounds.size.height - iconFrame.size.height) / 2;
        iconView.frame = iconFrame;
        
        [cell addSubview:iconView];
    }
    
    PAYFormButton *formButton  = [PAYFormButton new];
    formButton.section        = self.section;
    formButton.cell           = cell;
    formButton.titleLabel     = titleLabel;
    formButton.style          = style;
    formButton.iconView       = iconView;
    
    if(style == PAYFormButtonStyleDisabledCentered){
        formButton.enabled = NO;
    }
    
    if (style == PAYFormButtonStyleSelection || style == PAYFormButtonStyleIconSelection){
        [self.section.selectionButtonList addObject:formButton];
        
        __block PAYFormSelectionBlock selectionBlockForBlock = selectionBlock;
        formButton.selectionBlock = ^(PAYFormView *formView){
            PAYFormButton *touchedFormButton = (PAYFormButton *)formView;
            formView.section.selectedButton = touchedFormButton;
            
            selectionBlockForBlock(formView);
        };
    } else {
        formButton.selectionBlock = selectionBlock;
    }
    
    if (configureBlock){
        configureBlock(formButton);
    }
    
    [self.section.views addObject:formButton];
    
    return formButton;
}

- (void)addView:(void(^)(PAYFormView *))configureBlock {
    PAYFormView *formView = [PAYFormView new];
    formView.cell        = self.defaultCell;
    formView.section     = self.section;
    
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
