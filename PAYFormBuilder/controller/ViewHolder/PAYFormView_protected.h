//
//  PAYFormView_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"

@interface PAYFormView ()

/**
 *  The view, where all sub-components are added. This view has to be manipulated
 *  to change the appearance of one row of the form.
 */
@property (nonatomic, retain) UITableViewCell *view;

/**
 *  Focusses sub components that could be focused (textfields for example):
 *
 *  @return true, when receiver accepts the first responder request, false otherwise
 */
- (BOOL)becomeFirstResponder;

@end
