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
                               configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock {
    PAYFormSingleLineTextField *formField = [PAYFormSingleLineTextField new];
    
    formField.cell = self.defaultCell;
    if (!PAYStyle.sectionTheme.fixedSeperatorInset) {
        formField.cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
    }
    
    formField.textField = self.defaultTextField;
    formField.textField.placeholder = placeholder;
    [formField.view addSubview:formField.textField];
    
    NSDictionary *views = @{@"view" : formField.view, @"textField" : formField.textField};
    if (name) {
        formField.label      = self.defaultLabel;
        formField.label.text = name;
        [formField.view addSubview:formField.label];
        
        [self addDefaultLabelConstrainsToLabel:formField.label withFormView:formField];
        
        NSDictionary *views = @{@"view" : formField.view, @"label" : formField.label, @"textField" : formField.textField};
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[label]-horzMargin-[textField]-horzMargin-|"
                                                                           options:0
                                                                           metrics:self.metrics
                                                                             views:views];
            formField.viewLabelControlConstraint = constraints[0];
            formField.viewControlRightConstraint = constraints[1];
            
            [formField.view addConstraint:formField.viewLabelControlConstraint];
            [formField.view addConstraint:formField.viewControlRightConstraint];
        }
    } else {
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-horzMargin-[textField]-horzMargin-|"
                                                                           options:0
                                                                           metrics:self.metrics
                                                                             views:views];
            formField.viewControlLeftConstraint = constraints[0];
            formField.viewControlRightConstraint = constraints[1];
            
            [formField.view addConstraint:formField.viewControlLeftConstraint];
            [formField.view addConstraint:formField.viewControlRightConstraint];
        }
    }
    
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[textField(rowHeight)]-0-|"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formField.viewControlTopConstraint = constraints[0];
        formField.controlHeightContraint = constraints[1];
        formField.viewControlBottomConstraint = constraints[2];
        
        [formField.view addConstraint:formField.viewControlTopConstraint];
        [formField.textField addConstraint:formField.controlHeightContraint];
        [formField.view addConstraint:formField.viewControlBottomConstraint];
    }
    
    if (configureBlock) {
        configureBlock(formField);
    }
    
    return formField;
}

+ (PAYFormMultiLineTextField *)textViewWithName:(NSString *)name
                                    placeholder:(NSString *)placeholder
                                     adjustable:(BOOL)isAdjustable
                                 configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock {
    PAYFormMultiLineTextField *formField = [PAYFormMultiLineTextField new];
    formField.cell = self.defaultCell;
    
    
    SZTextView *textView            = self.defaultTextView;
    textView.font                   = PAYStyle.tableTheme.font;
    textView.placeholderTextColor   = PAYStyle.sectionTheme.placeholderColor;
    if (placeholder) {
        textView.placeholder = placeholder;
    }
    formField.textView = textView;
    [formField.view addSubview:textView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(textView, formField.view);
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-horzMargin-[textView]-horzMargin-|"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formField.viewControlLeftConstraint = constraints[0];
        formField.viewControlRightConstraint = constraints[1];
        
        [formField.view addConstraint:formField.viewControlLeftConstraint];
        [formField.view addConstraint:formField.viewControlRightConstraint];
    }
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[textView(>=textViewHeight@200)]-0-|"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formField.viewControlTopConstraint = constraints[0];
        formField.controlHeightContraint = constraints[1];
        formField.viewControlBottomConstraint = constraints[2];
        
        [formField.view addConstraint:formField.viewControlTopConstraint];
        [formField.control addConstraint:formField.controlHeightContraint];
        [formField.view addConstraint:formField.viewControlBottomConstraint];
    }
    
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
                             icon:(UIImage *)icon
                            style:(PAYFormButtonStyle)style
                   selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock
                   configureBlock:(void(^)(PAYFormButton *))configureBlock {
    PAYFormButton *formButton  = [PAYFormButton new];
    formButton.cell = self.defaultCell;
    if (style == PAYFormButtonStyleDisclosure) {
        if (PAYStyle.sectionTheme.detailAccessoryViewProviderBlock) {
            formButton.cell.accessoryView = PAYStyle.sectionTheme.detailAccessoryViewProviderBlock();
        }
        formButton.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (style == PAYFormButtonStyleSelection) {
        if (PAYStyle.sectionTheme.checkmarkAccessoryViewProviderBlock) {
            formButton.cell.accessoryView = PAYStyle.sectionTheme.checkmarkAccessoryViewProviderBlock();
        }
        formButton.cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    if (!PAYStyle.sectionTheme.fixedSeperatorInset) {
        if (style == PAYFormButtonStylePrimary || style == PAYFormButtonStyleCentered) {
            formButton.cell.separatorInset = UIEdgeInsetsZero;
        } else {
            formButton.cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
        }
    }
    
    formButton.cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (style != PAYFormButtonStyleEmpty) {
        formButton.label = self.defaultLabel;
        formButton.label.font = PAYStyle.tableTheme.font;
        formButton.label.userInteractionEnabled = NO;
        formButton.label.text = text;
        if (style == PAYFormButtonStyleCentered || style == PAYFormButtonStylePrimary || style == PAYFormButtonStyleHilighted) {
            formButton.label.textAlignment = NSTextAlignmentCenter;
        }
        
        [formButton.view addSubview:formButton.label];
        
        formButton.label.textColor = [PAYStyle.sectionTheme buttonTextColorForStyle:style];
        
        [self addDefaultLabelConstrainsToLabel:formButton.label withFormView:formButton];
        formButton.labelWidthConstraint.active = NO;
        
        if (icon) {
            formButton.iconView = [[UIImageView alloc] initWithImage:icon];
            formButton.iconView.contentMode = UIViewContentModeScaleAspectFill;
            formButton.iconView.translatesAutoresizingMaskIntoConstraints = NO;
            [formButton.view addSubview:formButton.iconView];
            
            formButton.viewLabelLeftConstraint.active = NO;
            
            NSDictionary *views = @{@"icon" : formButton.iconView, @"view" : formButton.view, @"label" : formButton.label};
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[icon(iconSize)]"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.iconWidthConstraint = constraints[0];
                
                [formButton.iconView addConstraint:formButton.iconWidthConstraint];
            }
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon(iconSize)]"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.iconHeightConstraint = constraints[0];
                
                [formButton.iconView addConstraint:formButton.iconHeightConstraint];
            }
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-horzMargin-[icon]-horzMargin-[label]"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.viewIconLeftConstraint = constraints[0];
                formButton.viewIconLabelConstraint = constraints[1];
                
                [formButton.view addConstraint:formButton.viewIconLeftConstraint];
                [formButton.view addConstraint:formButton.viewIconLabelConstraint];
            }
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[view]-(<=1)-[icon]"
                                                                               options:NSLayoutFormatAlignAllCenterY
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.viewIconCenterVerticalConstraint = constraints[0];
                formButton.viewIconCenterVerticalHelperConstraint = constraints[1];
                
                [formButton.view addConstraint:formButton.viewIconCenterVerticalConstraint];
                [formButton.view addConstraint:formButton.viewIconCenterVerticalHelperConstraint];
            }
        }
        
        if (detailText) {
            formButton.detailLabel = self.defaultLabel;
            formButton.detailLabel.text = detailText;
            formButton.detailLabel.textColor = PAYStyle.sectionTheme.buttonDetailTextColor;
            formButton.detailLabel.textAlignment = NSTextAlignmentRight;
            [formButton.detailLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [formButton.view addSubview:formButton.detailLabel];
            
            NSDictionary *views = @{@"label" : formButton.label, @"detailLabel" : formButton.detailLabel, @"view" : formButton.view};
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[label]-horzMargin-[detailLabel]-detailLabelMarginRight-|"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.viewLabelDetailLabelConstraint = constraints[0];
                formButton.viewDetailLabelRightConstraint = constraints[1];
                
                [formButton.view addConstraint:formButton.viewLabelDetailLabelConstraint];
                [formButton.view addConstraint:formButton.viewDetailLabelRightConstraint];
            }
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[detailLabel(rowHeight)]-0-|"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.viewDetailLabelTopConstraint = constraints[0];
                formButton.detailLabelHeightConstraint = constraints[1];
                formButton.viewDetailLabelBottomConstraint = constraints[2];
                
                [formButton.view addConstraint:formButton.viewDetailLabelTopConstraint];
                [formButton.detailLabel addConstraint:formButton.detailLabelHeightConstraint];
                [formButton.view addConstraint:formButton.viewDetailLabelBottomConstraint];
            }
        } else {
            NSDictionary *views = @{@"view" : formButton.view, @"label" : formButton.label};
            {
                NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[label]-horzMargin-|"
                                                                               options:0
                                                                               metrics:self.metrics
                                                                                 views:views];
                formButton.viewLabelRightConstraint = constraints[0];
                [formButton.view addConstraint:formButton.viewLabelRightConstraint];
            }
        }
    }
    
    
    formButton.selectionBlock = selectionBlock;
    
    if (configureBlock){
        configureBlock(formButton);
    }
    
    return formButton;
}

+ (PAYFormSwitch *)switchWithName:(NSString *)name
                   configureBlock:(void(^)(PAYFormSwitch *))configureBlock {
    PAYFormSwitch *formSwitch = [PAYFormSwitch new];
    
    formSwitch.cell = self.defaultCell;
    
    formSwitch.label      = self.defaultLabel;
    formSwitch.label.text = name;
    [formSwitch.view addSubview:formSwitch.label];
    
    [self addDefaultLabelConstrainsToLabel:formSwitch.label withFormView:formSwitch];
    formSwitch.labelWidthConstraint.active = NO;
    
    formSwitch.switchControl = [PAYSwitch new];
    formSwitch.switchControl.translatesAutoresizingMaskIntoConstraints = NO;
    [formSwitch.view addSubview:formSwitch.switchControl];
    
    NSDictionary *views = @{@"view" : formSwitch.view, @"label" : formSwitch.label, @"switch" : formSwitch.switchControl};
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[label]-horzMargin-[switch]-horzMargin-|"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formSwitch.viewLabelControlConstraint = constraints[0];
        formSwitch.viewControlRightConstraint = constraints[1];
        
        [formSwitch.view addConstraint:formSwitch.viewLabelControlConstraint];
        [formSwitch.view addConstraint:formSwitch.viewControlRightConstraint];
    }
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[view]-(<=1)-[switch]"
                                                                       options:NSLayoutFormatAlignAllCenterY
                                                                       metrics:self.metrics
                                                                         views:views];
        formSwitch.viewSwitchCenterVerticalConstraint = constraints[0];
        formSwitch.viewSwitchCenterVerticalHelperConstraint = constraints[1];
        
        [formSwitch.view addConstraint:formSwitch.viewSwitchCenterVerticalConstraint];
        [formSwitch.view addConstraint:formSwitch.viewSwitchCenterVerticalHelperConstraint];
    }

    if (configureBlock) {
        configureBlock(formSwitch);
    }
    
    return formSwitch;
}

+ (UITableViewCell *)defaultCell {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor  = UIColor.whiteColor;
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    if (PAYStyle.sectionTheme.fixedSeperatorInset) {
        cell.separatorInset = PAYStyle.sectionTheme.seperatorInset;
    }
    return cell;
}

+ (UILabel *)defaultLabel {
    UILabel *label = [UILabel new];
    
    label.font            = PAYStyle.tableTheme.font;
    label.textColor       = PAYStyle.sectionTheme.textColor;
    label.adjustsFontSizeToFitWidth = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

+ (void)addDefaultLabelConstrainsToLabel:(UILabel *)label withFormView:(PAYFormView *)formView
{
    NSDictionary *views = NSDictionaryOfVariableBindings(formView.view, label);
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-horzMargin-[label]"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formView.viewLabelLeftConstraint = constraints[0];
        [formView.view addConstraint:formView.viewLabelLeftConstraint];
    }
    if (PAYStyle.sectionTheme.fixedLabelWidth) {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[label(labelWidth)]"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formView.labelWidthConstraint = constraints[0];
        [formView.view addConstraint:formView.labelWidthConstraint];
    } else {
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label(rowHeight)]-0@200-|"
                                                                       options:0
                                                                       metrics:self.metrics
                                                                         views:views];
        formView.viewLabelTopConstraint = constraints[0];
        formView.labelHeightConstraint = constraints[1];
        formView.viewLabelBottomConstraint = constraints[2];
        
        [formView.view addConstraint:formView.viewLabelTopConstraint];
        [label addConstraint:formView.labelHeightConstraint];
        [formView.view addConstraint:formView.viewLabelBottomConstraint];
    }
}

+ (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textAlignment   = PAYStyle.sectionTheme.fieldTextAlignment;
    textField.font            = PAYStyle.tableTheme.font;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    return textField;
}

+ (SZTextView *)defaultTextView {
    SZTextView *textView        = [SZTextView new];
    textView.font               = PAYStyle.tableTheme.font;
    textView.textContainerInset = UIEdgeInsetsMake(textView.font.lineHeight, 0, textView.font.lineHeight, 0);
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    return textView;
}

+ (NSDictionary *)metrics {
    return @{@"horzMargin" : @(PAYStyle.sectionTheme.horizontalMargin),
             @"labelWidth" : @(PAYStyle.sectionTheme.labelWidth),
             @"rowHeight" : @(PAYStyle.tableTheme.rowHeight),
             @"textViewHeight" : @(floor(PAYStyle.tableTheme.font.lineHeight * (PAYStyle.sectionTheme.textViewLineCount + 2))),
             @"iconSize" : @(PAYStyle.sectionTheme.iconSize),
             @"detailLabelMarginRight" : @(PAYStyle.sectionTheme.detailLabelMarginRight)};
}

@end
