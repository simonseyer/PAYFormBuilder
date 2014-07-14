//
//  PAYFormMultiLineTextField_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormMultiLineTextField.h"

@interface PAYFormMultiLineTextField ()

/**
 *  The text view component
 */
@property (nonatomic, retain) UITextView *textView;

/**
 *  The default height of the text field
 */
@property (nonatomic, assign) CGFloat defaultHeight;

@property (nonatomic, retain) NSString *name;

@end
