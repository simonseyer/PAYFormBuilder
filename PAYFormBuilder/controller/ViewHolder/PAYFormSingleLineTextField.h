//
//  PAYFormSingleLineTextField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"

/**
 *  A form view with a single line textfield
 */
@interface PAYFormSingleLineTextField : PAYFormTextField

/**
 *  The label that is display in front of the textfield
 */
@property (nonatomic, retain) UILabel *label;

/**
 *  The textfield component
 */
@property (nonatomic, retain) UITextField *textField;

/**
 *  A text field delegate that is attached to the textfield
 */
@property (nonatomic, weak) id<UITextFieldDelegate> delegate;

/**
 *  When true, the textfield is expanded to the whole width
 *  of the form row when it is focused.
 *  When false, it stays the sames size on focus.
 */
@property (nonatomic, assign) BOOL expanding;

/**
 *  The default frame of the control
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 *  The frame, when the textfield is expanded
 */
@property (nonatomic, assign) CGRect expandedFrame;

/**
 *  Enables the secure input mode. Use this, 
 *  for allowing the user to enter passwords.
 */
- (void)activateSecureInput;

@end
