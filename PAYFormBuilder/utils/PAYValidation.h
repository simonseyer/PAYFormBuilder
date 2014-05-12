//
//  PAYValidation.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 12.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"

@interface PAYValidation : NSObject

+ (PAYFormFieldValidationBlock)integerValidationBlock;

@end
