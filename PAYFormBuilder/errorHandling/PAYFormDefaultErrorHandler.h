//
//  DefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormTable.h"

@class PAYFormErrorMessage;

/**
 *  An error handler that displays dialogs for errors.
 */
@interface PAYFormDefaultErrorHandler : NSObject

/**
 *  Define an error message that sould be shown when an error with the error code occur
 *
 *  @param errorMessage the error message
 *  @param code         the code of the errro
 */
+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;

/**
 *  Set the text of the button that is used to hide the dialog
 *
 *  @param text the text
 */
+ (void)setButtonText:(NSString *)text;

@end
