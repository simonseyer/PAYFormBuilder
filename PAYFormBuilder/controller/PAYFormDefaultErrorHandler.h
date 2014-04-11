//
//  DefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"

@interface PAYFormErrorMessage : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;

+ (instancetype)errorMessageWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)errorMessageWithError:(NSError *)error;

@end

typedef PAYFormErrorMessage *(^PAYFormErrorMessageBlock)(id<PAYValidatableFormCell> formCell);

@interface PAYFormDefaultErrorHandler : NSObject

+ (void)setTitle:(NSString *)title message:(NSString *)message forErrorCode:(NSUInteger)code;
+ (void)setErrorMessageBlock:(PAYFormErrorMessageBlock)messageBlock forErrorCode:(NSUInteger)code;
+ (PAYFormTableFailBlock)failBlock;

@end
