//
//  PAYFormMultiLineTextField.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormMultiLineTextField.h"
#import "PAYFormMultiLineTextField_protected.h"
#import "PAYMessageInterceptor_protected.h"
#import "PAYErrorCodes.h"
#import "PAYFormView_protected.h"
#import "PAYFormField_protected.h"
#import "PAYNotifications.h"
#import "PAYStyle.h"

@interface PAYFormMultiLineTextField () <UITextViewDelegate>

@end


@implementation PAYFormMultiLineTextField {
    PAYMessageInterceptor* _messageInterceptor;
}

- (id)init {
    self = [super init];
    if (self) {
        _messageInterceptor = [[PAYMessageInterceptor alloc] initWithMiddleMan:self];
    }
    return self;
}

- (NSString *)value {
    return self.textView.text;
}

- (NSString *)name {
    if ([self.textView respondsToSelector:@selector(placeholder)]) {
        return [self.textView performSelector:@selector(placeholder)];
    }
    return @"";
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textView becomeFirstResponder];
}

#pragma mark - onDone overwrites

- (void)setNextFormField:(PAYFormField *)nextFormField {
    super.nextFormField = nextFormField;
}

- (void)setCompletionBlock:(PAYFormFieldCompletionBlock)completionBlock {
    super.completionBlock = completionBlock;
}

#pragma mark - Getter and setter for textField

- (void)setTextView:(UITextView *)textView {
    self.control = (UIView<PAYFormControl> *)textView;
    self.defaultHeight = textView.frame.size.height;
    textView.delegate = (id<UITextViewDelegate>)_messageInterceptor;
}

- (UITextView *)textView {
    return (UITextView *)self.control;
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    _messageInterceptor.receiver = delegate;
}

- (id<UITextViewDelegate>)delegate {
    return _messageInterceptor.receiver;
}

#pragma mark - Style text field

- (void)setEnabled:(BOOL)enabled {
    self.textView.editable = enabled;
}

- (BOOL)isEnabled {
    return self.textView.editable;
}

# pragma mark - Error styling

- (void)styleForError:(NSError *)error {
    if (error) {
        self.textView.textColor = PAYStyle.sectionTheme.errorTextColor;
    } else {
        self.textView.textColor = PAYStyle.sectionTheme.textColor;
    }
}

#pragma mark - UITextFieldDelegate's implementation

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
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
        applyText = [_messageInterceptor.receiver textView:textView shouldChangeTextInRange:range replacementText:newText];
    }
    
    if (applyText && self.formatBlock) {
        textView.text = newText;
        applyText = NO;
    }
    
    return  applyText;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (_isAdjustable) {
        CGFloat maxHeight = floor(PAYStyle.tableTheme.font.lineHeight * (PAYStyle.sectionTheme.textViewMaxLineCount + 2));
        [self adjustSizeToContentWithMaxHeight:maxHeight];
    }
}

- (void)adjustSizeToContent {
    [self adjustSizeToContentWithMaxHeight:CGFLOAT_MAX];
}

- (void)adjustSizeToContentWithMaxHeight:(CGFloat)maxHeight {
    CGFloat minHeight = floor(PAYStyle.tableTheme.font.lineHeight * (PAYStyle.sectionTheme.textViewLineCount + 2));
    [self updateHeightWithMinHeight:minHeight maxHeight:maxHeight];
}

- (void)updateHeightWithMinHeight:(CGFloat)minHeight maxHeight:(CGFloat)maxHeight {
    CGFloat newHeight =  [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)].height;
    newHeight = MIN(newHeight, maxHeight);
    newHeight = MAX(newHeight, minHeight);
    
    BOOL heightChanged = (newHeight != self.textView.frame.size.height);
    if (heightChanged) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PAYFormRowHeightChangeBeginNotification object:nil];
        self.controlHeightContraint.constant = newHeight;
        [[NSNotificationCenter defaultCenter] postNotificationName:PAYFormRowHeightChangeEndNotification object:nil];
    }
}


@end
