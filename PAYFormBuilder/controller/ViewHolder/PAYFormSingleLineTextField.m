//
//  PAYFormSingleLineTextField.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSingleLineTextField.h"
#import "PAYMessageInterceptor.h"


static const NSUInteger RPFormSingleLineTextFieldDefaultMaxTextLength = 255;
static const NSUInteger RPFormSingleLineTextFieldPasswordMaxTextLength = 128;


@interface PAYFormSingleLineTextField () <UITextFieldDelegate>

@property (nonatomic, assign) UITextFieldViewMode defaultClearButtonMode;

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
    return self.label.text;
}

- (BOOL)becomeFirstResponder {
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
    } else {
        self.textField.textAlignment   = NSTextAlignmentNatural;
        self.textField.clearButtonMode = self.defaultClearButtonMode;
    }
}

# pragma mark - Error styling

- (void)styleForError:(NSError *)error {
    if (error) {
        self.textField.textColor = self.defaultErrorColor;
        self.label.textColor     = self.defaultErrorColor;
    } else {
        self.textField.textColor = self.defaultTextColor;
        self.label.textColor     = self.defaultTextColor;
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
    newText = self.cleanBlock(self, newText);
    
    if (self.maxTextLength > 0 && newText.length > self.maxTextLength && !self.mayExceedMaxLength) {
        return NO;
    }
    
    if (self.validateWhileEnter) {
        NSError *error = [self validate];
        
        // Suppress error with code PAYFormTextFieldBelowMinLength while still entering text
        if ([error.domain isEqualToString:PAYFormFieldErrorDomain] && error.code == PAYFormTextFieldBelowMinLengthErrorCode) {
            error = nil;
        }
        [self styleForError:error];
    }
    
    if (self.formatBlock) {
        textField.text = self.formatBlock(self, newText);
        
        return NO;
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        return [_messageInterceptor.receiver textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
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
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:500.0f
          initialSpringVelocity:0.0f
                        options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^{
                         self.textField.frame = expand ? self.expandedFrame : self.defaultFrame;
                         self.label.alpha     = expand ? 0 : 1;
                     } completion:nil];
}

@end
