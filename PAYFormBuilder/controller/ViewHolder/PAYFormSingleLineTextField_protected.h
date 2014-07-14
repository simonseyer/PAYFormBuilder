//
//  PAYFormSingleLineTextField_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSingleLineTextField.h"

@interface PAYFormSingleLineTextField ()

/**
 *  The label that is display in front of the textfield
 */
@property (nonatomic, retain) UILabel *label;

/**
 *  The textfield component
 */
@property (nonatomic, retain) UITextField *textField;

/**
 *  The default frame of the control
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 *  The frame, when the textfield is expanded
 */
@property (nonatomic, assign) CGRect expandedFrame;

@end
