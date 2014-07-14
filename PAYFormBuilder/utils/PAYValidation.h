//
//  PAYValidation.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 12.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormField.h"

/**
 *  A collection of validators
 */
@interface PAYValidation : NSObject

/**
 *  Get an validator that validates for integer values
 *
 *  @return the validation block
 */
+ (PAYFormFieldValidationBlock)integerValidationBlock;

@end
