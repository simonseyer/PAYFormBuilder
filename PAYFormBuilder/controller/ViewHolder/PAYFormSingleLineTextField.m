//
//  PAYFormSingleLineTextField.m
//  paij
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormSingleLineTextField.h"
#import "PAYMessageInterceptor.h"



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
        UIColor *redColor = [UIColor colorFromHex:0xFFFF3B30];
        self.textField.textColor = redColor;
        self.label.textColor     = redColor;
    } else {
        UIColor *defaultColor = [UIColor colorFromHex:0xFF323232];
        self.textField.textColor = defaultColor;
        self.label.textColor     = defaultColor;
    }
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
        if ([error.domain isEqualToString:PAYFormFieldErrorDomain] && error.code == PAYFormTextFieldBelowMinLength) {
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

@end
