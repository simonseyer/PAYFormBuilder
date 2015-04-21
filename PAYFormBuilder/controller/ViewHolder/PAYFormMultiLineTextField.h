//
//  PAYFormMultiLineTextField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"

/**
 *  A form view with a multiline textfield
 */
@interface PAYFormMultiLineTextField : PAYFormTextField

/**
 *  The text view component
 */
@property (nonatomic, retain, readonly) UITextView *textView;

/**
 *  A text view delegate that is attached to the textview
 */
@property (nonatomic, weak) id<UITextViewDelegate> delegate;

/**
 *  A property to set for dynamic height adjustable field
 */
@property (nonatomic, assign) BOOL isAdjustable;

/**
 *  Adjusts the height of the text view to the content height
 */
- (void)adjustSizeToContent;

/**
 *  Adjusts the height of the text view to the content height
 *
 *  @param maxHeight the maximum height of the text view
 */
- (void)adjustSizeToContentWithMaxHeight:(CGFloat)maxHeight;

@end
