//
//  PAYFormMultiLineTextField.h
//  paij
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormTextField.h"


@interface PAYFormMultiLineTextField : PAYFormTextField

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, weak) id<UITextViewDelegate> delegate;

@property (nonatomic, assign) CGFloat defaultHeight;

- (void)adjustSizeToContent;
- (void)adjustSizeToContentWithMaxHeight:(CGFloat)maxHeight;

+ (PAYFormFieldErrorStylingBlock)errorStylingBlock;
+ (void)setErrorStylingBlock:(PAYFormFieldErrorStylingBlock)block;

@end
