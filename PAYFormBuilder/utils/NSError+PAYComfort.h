//
//  NSError+PAYComfort.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"

@interface NSError (PAYComfort)

+ (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message control:(id)control;
+ (NSError *)validationErrorWithCode:(NSUInteger)code control:(id)control;

- (NSString *)title;
- (NSString *)message;
- (PAYFormView<PAYValidatableFormCell> *)field;

@end
