//
//  PAYFormField.h
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"

@protocol PAYFormControl;

extern NSString *const PAYFormFieldErrorDomain;

typedef enum {
    PAYFormFieldRequiredButEmptyErrorCode = 1,
} PAYFormFieldErrorCodes;

@interface PAYFormField : PAYFormView <PAYValidatableFormCell, UITextFieldDelegate>

- (NSString *)name;

@property (nonatomic, retain) UIView<PAYFormControl> *control;

@property (nonatomic, retain) PAYFormField *nextFormField;
@property (nonatomic, copy) PAYFormFieldCompletionBlock completionBlock;

@property (nonatomic, copy) PAYFormFieldFormatBlock formatBlock;
@property (nonatomic, copy) PAYFormFieldCleanBlock cleanBlock;
@property (nonatomic, copy) PAYFormFieldValidationBlock validationBlock;

@property (nonatomic, copy) PAYFormFieldErrorStylingBlock errorStylingBlock;
@property (nonatomic, retain) NSError *missingError;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, strong) NSError *error;

- (id)value;
- (id)cleanedValue;
- (BOOL)isEmpty;

- (NSError *)doValidate;
- (NSError *)prevalidate;
- (void)reset;

- (void)jumpToNextField;
- (BOOL)becomeFirstResponder;

- (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message;

@end


@protocol PAYFormControl <NSObject>

- (BOOL)isEnabled;

@end