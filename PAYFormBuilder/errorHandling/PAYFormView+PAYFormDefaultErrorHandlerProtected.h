//
//  PAYFormView+PAYFormDefaultErrorHandlerProtected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYFormDefaultErrorHandler.h"

@interface PAYFormView (PAYFormDefaultErrorHandlerProtected)

+ (nullable NSMutableDictionary *)classErrorMessages;
+ (void)setClassErrorMessages:(nonnull NSMutableDictionary *)errorMessages;

- (nullable NSMutableDictionary *)fieldErrorMessages;
- (void)setFieldErrorMessages:(nonnull NSMutableDictionary *)errorMessages;

/**
 *  Get an error message for a code. Error messages on the object are preferred
 *  to error messages on the class and error messages on more specialized classes
 *  are preferred to error messages on more abstract classes.
 *
 *  @param code the code of the error
 *
 *  @return the error message corresponding to the code or nil,
 *          if there was no error message found
 */
- (nullable PAYFormErrorMessage *)errorMessageForErrorCode:(NSUInteger)code;

@end
