//
//  PAYFormField.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"

@protocol PAYFormControl;

extern NSString *const PAYFormFieldErrorDomain;

typedef enum {
    PAYFormFieldRequiredButEmptyErrorCode = 1,
} PAYFormFieldErrorCodes;

@interface PAYFormField : PAYFormView <PAYValidatableFormCell, UITextFieldDelegate>

@property (nonatomic, retain) UIView<PAYFormControl> *control;

@property (nonatomic, retain) PAYFormField *nextFormField;
@property (nonatomic, copy) PAYFormFieldCompletionBlock completionBlock;

@property (nonatomic, copy) PAYFormFieldFormatBlock formatBlock;
@property (nonatomic, copy) PAYFormFieldCleanBlock cleanBlock;
@property (nonatomic, copy) PAYFormFieldValidationBlock validationBlock;

- (void)styleForError:(NSError *)error;
@property (nonatomic, assign) BOOL isRequired;

- (id)value;
- (id)cleanedValue;
- (BOOL)isEmpty;

- (NSError *)prevalidate;

- (void)jumpToNextField;

- (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message;
- (NSError *)validationErrorWithCode:(NSUInteger)code;

@end


@protocol PAYFormControl <NSObject>

- (BOOL)isEnabled;

@end