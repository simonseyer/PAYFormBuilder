//
//  PAYFormSingleLineTextField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 19.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"

@interface PAYFormSingleLineTextField : PAYFormTextField

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, weak) id<UITextFieldDelegate> delegate;

@property (nonatomic, assign) BOOL expanding;
@property (nonatomic, assign) CGRect defaultFrame;
@property (nonatomic, assign) CGRect expandedFrame;

- (void)activateSecureInput;

@end
