//
//  PAYFormView+PAYFormDefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYFormDefaultErrorHandler.h"

@interface PAYFormView (PAYFormDefaultErrorHandler)

/**
 *  Set an error message that is displayed for the error code. This method
 *  adds the error message to the form view class, so it is used globally across
 *  all forms you use in the app. It should be added only ones.
 *
 *  @param errorMessage the error message to display
 *  @param code         the error code, that should trigger the error message
 */
+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;

/**
 *  Set an error message that is displayed for the error code. This method
 *  adds the error message to form view object, so is only used for this form view.
 *
 *  @param errorMessage the error message to display
 *  @param code         the error code, that should trigger the error message
 */
- (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;

@end
