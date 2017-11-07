//
//  PAYFormField_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormField.h"

@interface PAYFormField ()

/**
 *  The control that is embedded in this view
 */
@property (nonatomic, retain, nonnull) UIView<PAYFormControl> *control;

/**
 *  The following form field in the tab chain
 */
@property (nonatomic, retain, nullable) PAYFormField *nextFormField;

/**
 *  A completion block that is used internally to trigger the jumping between the fields.
 */
@property (nonatomic, copy, nullable) PAYFormFieldCompletionBlock completionBlock;

/**
 *  Style component appropriate for the errror.
 *
 *  @param error the error the control should by styled for
 */
- (void)styleForError:(nullable NSError *)error;

/**
 *  Uses the integrated validators (for example required) to check
 *  the validity of the field
 *
 *  @return an error, when the field is not valid, nil otherwise
 */
- (nullable NSError *)prevalidate;

/**
 *  Triggers the jumping to the next control. If the next control is not
 *  focusable (for example a switch) the next focusable control is focused.
 */
- (void)jumpToNextField;

@end
