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
    formField.cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
    
    formField.textField = self.defaultTextField;
    formField.textField.placeholder = placeholder;
    [formField.view addSubview:formField.textField];
    
    if (name) {
        formField.label      = self.defaultLabel;
        formField.label.text = name;
        [formField.view addSubview:formField.label];
        
        [self addDefaultLabelConstrainsToLabel:formField.label withFormView:formField];
        
        [formField addConstraintWithFormat:[NSString stringWithFormat:@"[label]-%f-[textField]-%f-|",
                                            PAYStyle.sectionTheme.horizontalMargin,
                                            PAYStyle.sectionTheme.horizontalMargin]
                                       key:PAYFormViewControlHorizontalConstraintKey
                                   toViews:@{@"view" : formField.view, @"label" : formField.label, @"textField" : formField.textField}];
    } else {
        [formField addConstraintWithFormat:[NSString stringWithFormat:@"|-%f-[textField]-%f-|",
                                            PAYStyle.sectionTheme.horizontalMargin,
                                            PAYStyle.sectionTheme.horizontalMargin]
                                       key:PAYFormViewLabelHorizontalConstraintKey
                                   toViews:@{@"view" : formField.view, @"textField" : formField.textField}];
    }
    [formField addConstraintWithFormat:[NSString stringWithFormat:@"V:|-0-[textField(%f)]-0-|", PAYStyle.tableTheme.rowHeight]
                                   key:PAYFormViewControlVerticalConstraintKey
                               toViews:@{@"view" : formField.view, @"textField" : formField.textField}];
    
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
    textView.font                   = PAYStyle.theme.font;
    textView.placeholderTextColor   = PAYStyle.sectionTheme.placeholderColor;
    if (placeholder) {
        textView.placeholder = placeholder;
    }
    formField.textView = textView;
    [formField.view addSubview:textView];
    
    [formField addConstraintWithFormat:@"|-[textView]-|"
                                   key:PAYFormViewControlHorizontalConstraintKey
                               toViews:NSDictionaryOfVariableBindings(textView)];
    [formField addConstraintWithFormat:[NSString stringWithFormat:@"V:|-0-[textView(>=%f)]-0-|",
                                        floor(textView.font.lineHeight * (PAYStyle.sectionTheme.textViewLineCount + 2))]
                                   key:PAYFormViewControlVerticalConstraintKey
                               toViews:NSDictionaryOfVariableBindings(textView, formField.view)];
    
    
    
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
        formButton.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (style == PAYFormButtonStyleSelection) {
        formButton.cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    if (style == PAYFormButtonStylePrimary || style == PAYFormButtonStyleCentered) {
        formButton.cell.separatorInset = UIEdgeInsetsZero;
    } else {
        formButton.cell.separatorInset = UIEdgeInsetsMake(0, PAYStyle.sectionTheme.horizontalMargin, 0, 0);
    }
    
    formButton.cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (style != PAYFormButtonStyleEmpty) {
        formButton.titleLabel = self.defaultLabel;
        formButton.titleLabel.font = PAYStyle.theme.font;
        formButton.titleLabel.userInteractionEnabled = NO;
        formButton.titleLabel.text = text;
        if (style == PAYFormButtonStyleCentered || style == PAYFormButtonStylePrimary || style == PAYFormButtonStyleHilighted) {
            formButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [formButton.view addSubview:formButton.titleLabel];
        
        formButton.titleLabel.textColor = [PAYStyle.sectionTheme buttonTextColorForStyle:style];
        
        [self addDefaultLabelConstrainsToLabel:formButton.titleLabel withFormView:formButton];
        [formButton.view removeConstraints:formButton.constraints[PAYFormViewLabelWidthConstraintKey]];
        
        if (icon) {
            formButton.iconView = [[UIImageView alloc] initWithImage:icon];
            formButton.iconView.contentMode = UIViewContentModeScaleAspectFill;
            formButton.iconView.translatesAutoresizingMaskIntoConstraints = NO;
            [formButton.view addSubview:formButton.iconView];
            
            [formButton.view removeConstraints:formButton.constraints[PAYFormViewLabelHorizontalConstraintKey]];
            
            NSDictionary *viewDict = @{@"iconView" : formButton.iconView};
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"[iconView(%f)]", PAYStyle.sectionTheme.iconSize]
                                            key:PAYFormButtonIconWidthConstraintKey
                                        toViews:viewDict];
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"V:[iconView(%f)]", PAYStyle.sectionTheme.iconSize]
                                            key:PAYFormButtonIconHeightConstraintKey
                                        toViews:viewDict];
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"|-%f-[iconView]-%f-[label]",
                                                 PAYStyle.sectionTheme.horizontalMargin, PAYStyle.sectionTheme.horizontalMargin]
                                            key:PAYFormButtonIconHorizontalConstraintKey
                                        toViews:@{@"iconView" : formButton.iconView, @"cell" : formButton.view, @"label" : formButton.titleLabel}];
            [formButton addConstraintWithFormat:@"[cell]-(<=1)-[iconView]"
                                        options:NSLayoutFormatAlignAllCenterY
                                            key:PAYFormButtonIconVerticalConstraintKey
                                        toViews:@{@"iconView" : formButton.iconView, @"cell" : formButton.view}];
        }
        
        if (detailText) {
            formButton.detailLabel = self.defaultLabel;
            formButton.detailLabel.text = detailText;
            formButton.detailLabel.textColor = PAYStyle.sectionTheme.buttonDetailTextColor;
            formButton.detailLabel.textAlignment = NSTextAlignmentRight;
            [formButton.view addSubview:formButton.detailLabel];
            
            NSDictionary *viewDict = @{@"detailLabel" : formButton.detailLabel, @"view" : formButton.view};
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"[label]-%f-[detailLabel]",
                                               PAYStyle.sectionTheme.horizontalMargin]
                                          key:PAYFormViewLabelHorizontalConstraintKey
                                      toViews:@{@"label" : formButton.titleLabel, @"detailLabel" : formButton.detailLabel}];
            [formButton addConstraintWithFormat:@"[detailLabel]-0-|"
                                          key:PAYFormButtonDetailLabelHorizontalConstraintKey
                                      toViews:viewDict];
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"V:|-0-[detailLabel(%f)]-0-|", PAYStyle.tableTheme.rowHeight]
                                          key:PAYFormButtonDetailLabelVerticalConstraintKey
                                      toViews:viewDict];
        } else {
            [formButton addConstraintWithFormat:[NSString stringWithFormat:@"[label]-%f-|", PAYStyle.sectionTheme.horizontalMargin]
                                            key:PAYFormViewLabelWidthConstraintKey
                                        toViews:@{@"view" : formButton.view, @"label" : formButton.titleLabel}];
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
    [formSwitch.view removeConstraints:formSwitch.constraints[PAYFormViewLabelWidthConstraintKey]];
    
    formSwitch.switchControl = [PAYSwitch new];
    formSwitch.switchControl.translatesAutoresizingMaskIntoConstraints = NO;
    [formSwitch.view addSubview:formSwitch.switchControl];
    
    [formSwitch addConstraintWithFormat:[NSString stringWithFormat:@"[label]-%f-[switch]-%f-|",
                                        PAYStyle.sectionTheme.horizontalMargin,
                                        PAYStyle.sectionTheme.horizontalMargin]
                                   key:PAYFormViewControlHorizontalConstraintKey
                               toViews:@{@"view" : formSwitch.view, @"label" : formSwitch.label, @"switch" : formSwitch.switchControl}];
    [formSwitch addConstraintWithFormat:@"[cell]-(<=1)-[switch]"
                                options:NSLayoutFormatAlignAllCenterY
                                    key:PAYFormViewControlVerticalConstraintKey
                                toViews:@{@"switch" : formSwitch.switchControl, @"cell" : formSwitch.view}];

    if (configureBlock) {
        configureBlock(formSwitch);
    }
    
    return formSwitch;
}

+ (UITableViewCell *)defaultCell {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor  = UIColor.whiteColor;
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (UILabel *)defaultLabel {
    UILabel *label = [UILabel new];
    
    label.font            = PAYStyle.theme.font;
    label.textColor       = PAYStyle.sectionTheme.textColor;
    label.adjustsFontSizeToFitWidth = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

+ (void)addDefaultLabelConstrainsToLabel:(UILabel *)label withFormView:(PAYFormView *)formView
{
    NSDictionary *labelViewDict = NSDictionaryOfVariableBindings(formView.view, label);
    
    [formView addConstraintWithFormat:[NSString stringWithFormat:@"|-%f-[label]",
                                       PAYStyle.sectionTheme.horizontalMargin]
                                  key:PAYFormViewLabelHorizontalConstraintKey
                              toViews:labelViewDict];
    [formView addConstraintWithFormat:[NSString stringWithFormat:@"[label(%f)]",
                                       PAYStyle.sectionTheme.labelWidth]
                                  key:PAYFormViewLabelWidthConstraintKey
                              toViews:labelViewDict];
    [formView addConstraintWithFormat:[NSString stringWithFormat:@"V:|-0-[label(%f)]-0-|", PAYStyle.tableTheme.rowHeight]
                                  key:PAYFormViewLabelVerticalConstraintKey
                              toViews:labelViewDict];
}

+ (UITextField *)defaultTextField {
    UITextField *textField    = [UITextField new];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textAlignment   = PAYStyle.sectionTheme.fieldTextAlignment;
    textField.font            = PAYStyle.theme.font;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    return textField;
}

+ (SZTextView *)defaultTextView {
    SZTextView *textView        = [SZTextView new];
    textView.font               = PAYStyle.theme.font;
    textView.textContainerInset = UIEdgeInsetsMake(textView.font.lineHeight, 0, textView.font.lineHeight, 0);
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    return textView;
}

@end
