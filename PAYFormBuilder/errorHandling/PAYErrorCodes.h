//
//  PAYErrorCodes.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Different error codes that are used to mark validation errors
 */
typedef enum {
    /**
     *  Used to mark generic validation errors
     */
    PAYFormDefaultErrorCode,
    /**
     *  Used to mark errors indicating a missing value in a field that is marked as required
     */
    PAYFormMissingErrorCode,
    /**
     *  Used to mark errors indicating a too long value in a field that has maximum text length
     */
    PAYFormTextFieldAboveMaxLengthErrorCode,
    /**
     *  Used to mark errors indicating a too short value in a field that has minimum text length
     */
    PAYFormTextFieldBelowMinLengthErrorCode,
    /**
     *  Used to mark errors indicating a non-interger value in a field that has a integer validation block
     */
    PAYFormIntegerValidationErrorCode
} PAYFormErrorCodes;

/**
 *  Used to store the control that is not valid in the user info of the error
 */
extern NSString * const PAYFormErrorControlKey;

/**
 *  Error domain of the PAYFormBuilder
 */
extern NSString * const PAYFormErrorDomain;
