//
//  PAYErrorCodes.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PAYFormDefaultErrorCode,
    PAYFormMissingErrorCode,
    PAYFormTextFieldAboveMaxLengthErrorCode,
    PAYFormTextFieldBelowMinLengthErrorCode,
    PAYFormIntegerValidationErrorCode
} PAYFormErrorCodes;

extern NSString * const PAYFormErrorControlKey;
extern NSString * const PAYFormErrorRecoveryOptionsKey;
extern NSString * const PAYFormErrorDomain;