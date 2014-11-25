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


static const CGFloat PAYFormMultiLineTextFieldDefaultMaxHeightFactor = 5;


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

#pragma mark - UITextFieldDelegate's implementation

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    newText = self.cleanBlock(self, newText);
    
    if (self.maxTextLength > 0 && newText.length > self.maxTextLength && !self.mayExceedMaxLength) {
        return NO;
    }
    
    if (self.formatBlock) {
        textView.text = self.formatBlock(self, newText);
        
        return NO;
    }
    
    // Forward message
    if (_messageInterceptor.receiver && [_messageInterceptor.receiver respondsToSelector:_cmd]) {
        return [_messageInterceptor.receiver textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)adjustSizeToContent {
    [self adjustSizeToContentWithMaxHeight:PAYFormMultiLineTextFieldDefaultMaxHeightFactor * self.textView.font.lineHeight];
}

- (void)adjustSizeToContentWithMaxHeight:(CGFloat)maxHeight {
    CGSize dynamicSize = [self.textView.text sizeWithAttributes:@{ NSFontAttributeName : self.textView.font }];
    CGRect textViewRect = self.textView.frame;
    if (dynamicSize.height < self.defaultHeight) {
        textViewRect.size.height = self.defaultHeight;
    } else if (dynamicSize.height < maxHeight) {
        [self.textView sizeToFit];
    } else {
        textViewRect.size.height = maxHeight;
    }
    self.textView.frame = textViewRect;
    
    CGRect cellRect = self.view.frame;
    cellRect.size.height = textViewRect.size.height;
    self.view.frame = cellRect;
}

@end
