//
//  UIView+PAYKeyboardHandling.m
//  PAYFormBuilder
//
//  Created by Stephan Michels on 21.03.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "UIView+PAYKeyboardHandling.h"
#import <objc/runtime.h>
#import <BlocksKit/BlocksKit+UIKit.h>


@interface PAYTapToEndEditingDelegate : NSObject <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *hostView;

@end


@implementation PAYTapToEndEditingDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // Handle touch only for non input views
    if ([touch.view isKindOfClass:UIControl.class]) {
        return NO;
    }
    return YES;
}

@end



@interface UIView ()

@property (strong, nonatomic) PAYTapToEndEditingDelegate *tapToEndEditingDelegate;

@end


@implementation UIView (PAYKeyboardHandling)

static char tapToEndEditingDelegateKey;

- (void)setTapToEndEditingDelegate:(PAYTapToEndEditingDelegate *)tapToEndEditingDelegate {
    objc_setAssociatedObject(self, &tapToEndEditingDelegateKey, tapToEndEditingDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PAYTapToEndEditingDelegate *)tapToEndEditingDelegate {
    return objc_getAssociatedObject(self, &tapToEndEditingDelegateKey);
}

- (void)enableTapToEndEditing {
    // tap to close keyboard
    PAYTapToEndEditingDelegate *delegate = [PAYTapToEndEditingDelegate new];
    delegate.hostView = self;
    self.tapToEndEditingDelegate = delegate;
    
    @weakify(self);
    UITapGestureRecognizer *singleTap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            @strongify(self);
            [self endEditing:YES];
        } delay:0.18];
    singleTap.delegate             = delegate;
    singleTap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:singleTap];
}

@end
