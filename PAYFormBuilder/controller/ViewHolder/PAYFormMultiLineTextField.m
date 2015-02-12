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

# pragma mark - Error styling

- (void)styleForError:(NSError *)error {
    if (error) {
        self.textView.textColor = self.defaultErrorColor;
    } else {
        self.textView.textColor = self.defaultTextColor;
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
        [self changeHeight:YES];
    }
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

- (void)changeHeight:(BOOL)animated {
    CGFloat newHeight =  [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)].height;
    BOOL heightChanged = (newHeight != self.textView.frame.size.height);
    if (heightChanged) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PAYFormRowHeightChangeBeginNotification object:nil];
        if (animated) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 CGRect frame = self.textView.frame;
                                 frame.size.height = newHeight;
                                 self.textView.frame = frame;
                                 frame = self.view.frame;
                                 frame.size.height = newHeight;
                                 self.view.frame = frame;
                             }completion:^(BOOL finished) {
                                 [[NSNotificationCenter defaultCenter] postNotificationName:PAYFormRowHeightChangeEndNotification object:nil];
                             }];
        } else {
            CGRect frame = self.textView.frame;
            frame.size.height = newHeight;
            self.textView.frame = frame;
            frame = self.view.frame;
            frame.size.height = newHeight;
            self.view.frame = frame;
            [[NSNotificationCenter defaultCenter] postNotificationName:PAYFormRowHeightChangeEndNotification object:nil];
        }
    }
}


@end
