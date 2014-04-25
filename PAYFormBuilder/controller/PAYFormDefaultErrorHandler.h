//
//  DefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"


typedef NSString *(^PAYFormErrorMessageBlock)(id<PAYValidatableFormCell> formCell);


@interface PAYFormErrorMessage : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, assign) PAYFormErrorMessageBlock titleBlock;
@property (nonatomic, assign) PAYFormErrorMessageBlock messageBlock;

+ (instancetype)errorMessageWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)errorMessageWithError:(NSError *)error;
+ (instancetype)errorMessageWithTitleBlock:(PAYFormErrorMessageBlock)titleBlock messageBlock:(PAYFormErrorMessageBlock)messageBlock;

- (NSString *)titleForField:(id<PAYValidatableFormCell>)field;
- (NSString *)messageForField:(id<PAYValidatableFormCell>)field;

@end



@interface PAYFormDefaultErrorHandler : NSObject

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;
+ (PAYFormTableFailBlock)failBlock;

+ (void)setButtonText:(NSString *)text;
+ (NSString *)buttonText;

@end
