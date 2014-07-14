//
//  PAYFormMultiLineTextField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"

@class SZTextView;


/**
 *  A form view with a multiline textfield
 */
@interface PAYFormMultiLineTextField : PAYFormTextField

/**
 *  The text view component
 */
@property (nonatomic, retain, readonly) SZTextView *textView;

/**
 *  A text view delegate that is attached to the textview
 */
@property (nonatomic, weak) id<UITextViewDelegate> delegate;

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
