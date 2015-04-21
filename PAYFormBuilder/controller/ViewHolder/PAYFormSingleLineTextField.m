//
//  PAYFormSingleLineTextField.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSingleLineTextField.h"
#import "PAYFormSingleLineTextField_protected.h"
#import "PAYMessageInterceptor_protected.h"
#import "PAYErrorCodes.h"
#import "PAYFormView_protected.h"
#import "PAYFormField_protected.h"
#import "PAYStyle.h"


static const NSUInteger RPFormSingleLineTextFieldDefaultMaxTextLength = 255;
static const NSUInteger RPFormSingleLineTextFieldPasswordMaxTextLength = 128;


@interface PAYFormSingleLineTextField () <UITextFieldDelegate>

@property (nonatomic, assign) UITextFieldViewMode defaultClearButtonMode;
@property (nonatomic, assign) CGFloat savedLabelWidthConstraintConstant;
@property (nonatomic, assign) CGFloat savedLabelControlConstraintConstant;

@end

@implementation PAYFormSingleLineTextField {
    PAYMessageInterceptor *_messageInterceptor;
}

- (id)init {
    self = [super init];
    if (self) {
        _messageInterceptor = [[PAYMessageInterceptor alloc] initWithMiddleMan:self];
        self.maxTextLength = RPFormSingleLineTextFieldDefaultMaxTextLength;
    }
    return self;
}

- (NSString *)value {
    return self.textField.text;
}

- (NSString *)name {
    if (self.label.text.length > 0) {
        return self.label.text;
    } else if (self.textField.placeholder.length > 0) {
        return self.textField.placeholder;
    }
    return @"";
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textField becomeFirstResponder];
}

#pragma mark - onDone overwrites

- (void)setNextFormField:(PAYFormField *)nextFormField {
    super.nextFormField = nextFormField;
    if (nextFormField != nil) {
        self.textField.returnKeyType = UIReturnKeyNext;
    }
}

- (void)setCompletionBlock:(PAYFormFieldCompletionBlock)completionBlock {
    super.completionBlock = completionBlock;
    if (completionBlock != nil) {
        self.textField.returnKeyType = UIReturnKeyDone;
    }
}

#pragma mark - Getter and setter for textField

- (void)setTextField:(UITextField *)textField {
    self.control = (UIView<PAYFormControl> *)textField;
    textField.delegate = (id<UITextFieldDelegate>)_messageInterceptor;
}

- (UITextField *)textField {
    return (UITextField *)self.control;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    _messageInterceptor.receiver = delegate;
}

- (id<UITextFieldDelegate>)delegate {
    return _messageInterceptor.receiver;
}

#pragma mark - Style text field

- (void)setEnabled:(BOOL)enabled {
    self.textField.enabled = enabled;
    if (!enabled) {
        self.textField.textAlignment   = NSTextAlignmentRight;
        self.defaultClearButtonMode    = self.textField.clearButtonMode;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
        self.textField.textColor       = PAYStyle.sectionTheme.disabledTextColor;
    } else {
        self.textField.textAlignment   = PAYStyle.sectionTheme.fieldTextAlignment;
        self.textField.clearButtonMode = self.defaultClearButtonMode;
        self.textField.textColor       = PAYStyle.sectionTheme.textColor;
    }
}

- (BOOL)isEnabled {
    return self.textField.enabled;
}

# pragma mark - Error styling

- (void)styleForError:(NSError *)error {
    if (error) {
        self.textField.textColor = PAYStyle.sectionTheme.errorTextColor;
        self.label.textColor     = PAYStyle.sectionTheme.errorTextColor;
    } else {
        self.textField.textColor = PAYStyle.sectionTheme.textColor;
        self.label.textColor     = PAYStyle.sectionTheme.textColor;
    }
}

- (void)activateSecureInput {
    self.maxTextLength = RPFormSingleLineTextFieldPasswordMaxTextLength;
    
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType     = UITextAutocorrectionTypeNo;
    self.textField.spellCheckingType      = UITextSpellCheckingTypeNo;
    self.textField.secureTextEntry        = YES;
}

#pragma mark - UITextFieldDelegate's implementation

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL applyText = YES;
    newText = self.cleanBlock(self, newText);
    
    if (self.maxTextLength > 0 && newText.length > self.maxTextLength && !self.mayExceedMaxLength) {
        return NO;
    }
    
    if (self.validateWhileEnter) {
        NSError *error = [self validate];
        
        // Suppress error with code PAYFormTextFieldBelowMinLength while still entering text
        if ([error.domain isEqualToString:PAYFormErrorDomain] && error.code == PAYFormTextFieldBelowMinLengthErrorCode) {
            error = nil;
        }
        [self styleForError:error];
    }
    
    if (self.formatBlock) {
        newText = self.formatBlock(self, newText);
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        applyText = [_messageInterceptor.receiver textField:textField shouldChangeCharactersInRange:range replacementString:newText];
    }
    
    if (applyText && self.formatBlock) {
        textField.text = newText;
        applyText = NO;
    }
    
    return  applyText;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.nextFormField) {
        [self jumpToNextField];
    }
    if (self.completionBlock) {
        self.completionBlock();
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        return [_messageInterceptor.receiver textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.expanding) {
        [self expandTextfield:YES];
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        return [_messageInterceptor.receiver textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.expanding) {
        [self expandTextfield:NO];
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        return [_messageInterceptor.receiver textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (void)expandTextfield:(BOOL)expand {
    [self.view layoutIfNeeded];
    if (expand) {
        self.savedLabelWidthConstraintConstant = self.labelWidthConstraint.constant;
        self.savedLabelControlConstraintConstant = self.viewLabelControlConstraint.constant;
        self.labelWidthConstraint.constant = 0;
        self.viewLabelControlConstraint.constant = 0;
    } else if(self.labelWidthConstraint.constant == 0) {
        self.labelWidthConstraint.constant = self.savedLabelWidthConstraintConstant;
        self.viewLabelControlConstraint.constant = self.savedLabelControlConstraintConstant;
    }
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:500.0f
          initialSpringVelocity:0.0f
                        options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

@end
