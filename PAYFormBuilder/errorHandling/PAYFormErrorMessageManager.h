//
//  PAYErrorMessageManager.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 25.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PAYFormErrorMessage;


@interface PAYFormErrorMessageManager : NSObject

/**
 *  Define an error message that sould be shown when an error with the error code occur
 *
 *  @param errorMessage the error message
 *  @param code         the code of the errro
 */
+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;

@end
