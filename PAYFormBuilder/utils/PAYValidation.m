//
//  PAYValidation.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 12.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYValidation.h"
#import "PAYFormField.h"
#import "PAYErrorCodes.h"

@implementation PAYValidation

+ (PAYFormFieldValidationBlock)integerValidationBlock {
    return ^NSError *(PAYFormField *formField){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:formField.cleanedValue];
        if (!!number) {
            return nil;
        } else {
            return [formField validationErrorWithCode:PAYFormIntegerValidationErrorCode];
        }
    };
}

@end
