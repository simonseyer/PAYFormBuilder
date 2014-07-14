//
//  PAYFormSingleLineTextField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"

/**
 *  A form view with a singleline textfield
 */
@interface PAYFormSingleLineTextField : PAYFormTextField

/**
 *  The label that is display in front of the textfield
 */
@property (nonatomic, retain, readonly) UILabel *label;

/**
 *  The textfield component
 */
@property (nonatomic, retain, readonly) UITextField *textField;

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
 *  Enables the secure input mode. Use this, 
 *  for allowing the user to enter passwords.
 */
- (void)activateSecureInput;

@end
