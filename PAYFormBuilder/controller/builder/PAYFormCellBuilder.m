//
//  PAYFormCellBuilder.m
//  Pods
//
//  Created by COBI on 13.04.15.
//
//

#import "PAYFormCellBuilder.h"
#import "PAYStyle.h"
#import "PAYFormSingleLineTextField_protected.h"
#import "PAYFormMultiLineTextField_protected.h"
#import "PAYFormButton_protected.h"
#import "PAYSwitch.h"
#import "PAYFormSwitch_protected.h"

@implementation PAYFormCellBuilder

+ (PAYFormSingleLineTextField *)fieldWithName:(NSString *)name
                                  placeholder:(NSString *)placeholder
                                     inBounds:(CGRect)bounds
                               configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    UITextField *textField    = [self defaultTextField];
    textField.placeholder     = placeholder;
    
    UILabel *label = nil;
    CGFloat leftFieldMargin = PAYStyle.sectionTheme.horizontalMargin;
    if (name) {
        label           = [self defaultLabelInBounds:bounds];
        label.text      = name;
        leftFieldMargin = CGRectGetMaxX(label.frame) + PAYStyle.sectionTheme.labelFieldSpacing;
        if (textField.textAlignment == NSTextAlignmentRight) {
            CGRect labelRect = label.frame;
            labelRect.size.width = bounds.size.width - 2 * PAYStyle.sectionTheme.horizontalMargin;
            label.frame = labelRect;
        }
    }
    
    CGRect expandedFieldFrame = CGRectInset(bounds, PAYStyle.sectionTheme.horizontalMargin, 0);
    CGRect fieldFrame         = bounds;
    fieldFrame.origin.x       = leftFieldMargin;
    fieldFrame.size.width    -= (fieldFrame.origin.x + PAYStyle.sectionTheme.horizontalMargin);
    textField.frame           = fieldFrame;
    
    UITableViewCell *cell = [self defaultCellInBounds:bounds];
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
    
    return formField;
}

+ (PAYFormMultiLineTextField *)textViewWithName:(NSString *)name
                                    placeholder:(NSString *)placeholder
                                       inBounds:(CGRect)bounds
                                     adjustable:(BOOL)isAdjustable
                                 configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    SZTextView *textView            = self.defaultTextView;
    textView.font                   = PAYStyle.theme.font;
    textView.placeholderTextColor   = PAYStyle.sectionTheme.placeholderColor;
    if (placeholder) {
        textView.placeholder            = placeholder;
    }
    
    CGRect textViewFrame  = bounds;
    // Two line heights for top and bottom contentInset
    if (isAdjustable) {
        textViewFrame.size.height = textView.font.lineHeight * PAYStyle.sectionTheme.textViewLineCount;
    }else {
        textViewFrame.size.height = textView.font.lineHeight * (2 + PAYStyle.sectionTheme.textViewLineCount);
    }
    textView.frame            = textViewFrame;
    
    UITableViewCell *cell = [self defaultCellInBounds:bounds];
    cell.frame            = textViewFrame;
    [cell addSubview:textView];
    
    PAYFormMultiLineTextField *formField = [PAYFormMultiLineTextField new];
    formField.view     = cell;
    formField.textView = textView;
    formField.name     = name;
    formField.isAdjustable = isAdjustable;
    formField.textView.scrollEnabled = !isAdjustable;
    
    if (configureBlock) {
        configureBlock(formField);
    }
    
    return formField;
}

+ (PAYFormButton *)buttonWithText:(NSString *)text
                       detailText:(NSString *)detailText
                            style:(PAYFormButtonStyle)style
                         inBounds:(CGRect)bounds
                   selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                   configureBlock:(void(^)(PAYFormButton *))configureBlock {
    UITableViewCell *cell = [self defaultCellInBounds:bounds];
    
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
        
        CGRect labelFrame = bounds;
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
            
            CGRect labelFrame = bounds;
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
        
        CGRect iconFrame = bounds;
        iconFrame.size = CGSizeMake(PAYStyle.sectionTheme.iconSize,
                                    PAYStyle.sectionTheme.iconSize);
        iconFrame.origin.x = PAYStyle.sectionTheme.iconMargin;
        iconFrame.origin.y = (bounds.size.height - iconFrame.size.height) / 2.0f;
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
    
    return formButton;
}

+ (PAYFormSwitch *)switchWithName:(NSString *)name
                         inBounds:(CGRect)bounds
                   configureBlock:(void(^)(PAYFormSwitch *))configureBlock {
    UILabel *label = [self defaultLabelInBounds:bounds];
    label.text     = name;
    
    UISwitch *switchControl   = [PAYSwitch new];
    
    CGRect switchFrame     = switchControl.frame;
    switchFrame.origin.x   = bounds.size.width - switchFrame.size.width - PAYStyle.sectionTheme.horizontalMargin;
    switchFrame.origin.y   = (bounds.size.height - switchFrame.size.height) / 2.0f;
    switchControl.frame    = switchFrame;
    
    CGRect labelFrame = label.frame;
    labelFrame.size.width  = switchFrame.origin.x;
    labelFrame.size.width -= labelFrame.origin.x + PAYStyle.sectionTheme.horizontalMargin;
    label.frame = labelFrame;
    
    UITableViewCell *cell = [self defaultCellInBounds:bounds];
    [cell addSubview:label];
    [cell addSubview:switchControl];
    
    PAYFormSwitch *formSwitch = [PAYFormSwitch new];
    formSwitch.view          = cell;
    formSwitch.label         = label;
    formSwitch.switchControl = switchControl;
    
    if (configureBlock) {
        configureBlock(formSwitch);
    }
    
    return formSwitch;
}

+ (UITableViewCell *)defaultCellInBounds:(CGRect)bounds {
    UITableViewCell *cell = [UITableViewCell new];
    cell.frame            = bounds;
    cell.backgroundColor  = UIColor.whiteColor;
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (UILabel *)defaultLabelInBounds:(CGRect)bounds {
    UILabel *label = [UILabel new];
    CGRect labelFrame     = bounds;
    labelFrame.origin.x   = PAYStyle.sectionTheme.horizontalMargin;
    labelFrame.size.width = PAYStyle.sectionTheme.labelWidth;
    label.frame           = labelFrame;
    label.font            = PAYStyle.theme.font;
    label.textColor       = PAYStyle.sectionTheme.textColor;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
}

+ (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textAlignment   = PAYStyle.sectionTheme.fieldTextAlignment;
    textField.font            = PAYStyle.theme.font;
    return textField;
}

+ (SZTextView *)defaultTextView {
    SZTextView *textView        = [SZTextView new];
    textView.font               = PAYStyle.theme.font;
    textView.textContainerInset = UIEdgeInsetsMake(textView.font.lineHeight, PAYStyle.sectionTheme.horizontalMargin,
                                                   textView.font.lineHeight, PAYStyle.sectionTheme.horizontalMargin);
    return textView;
}

@end
