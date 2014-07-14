//
//  NSError+PAYComfort.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYValidatableFormCell.h"

/**
 *  Comfort methods to create and access NSError
 */
@interface NSError (PAYComfort)

/**
 *  Create an error with a title, a message and a view control
 *
 *  @param title   the title
 *  @param message the message
 *  @param control the control view, that is related to the error
 *
 *  @return an error object
 */
+ (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message control:(id)control;

/**
 *  Create an error with an error code and a view control
 *
 *  @param code    the error code
 *  @param control the control view, that is related to the error
 *
 *  @return an error object
 */
+ (NSError *)validationErrorWithCode:(NSUInteger)code control:(id)control;

/**
 *  Get the title of the error
 *
 *  @return the title or nil, if the error has no title
 */
- (NSString *)title;

/**
 *  Get the message of the error
 *
 *  @return the message or nil, if the error has no message
 */
- (NSString *)message;

/**
 *  The related control view
 *
 *  @return the control view or nil, if there is no related control view
 */
- (id<PAYValidatableFormCell>)field;

@end
