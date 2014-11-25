//
//  PAYFormErrorStyler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 25.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYValidatableFormCell.h"

@interface PAYFormErrorStyler : NSObject

+ (void)styleField:(id<PAYValidatableFormCell>)field;

@end
