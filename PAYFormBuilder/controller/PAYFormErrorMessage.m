//
//  PAYErrorMessage.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormErrorMessage.h"
#import "PAYFormErrorMessage_protected.h"
#import "PAYFormField.h"
#import "NSError+PAYComfort.h"

@interface PAYFormErrorMessage ()

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, assign) PAYFormErrorMessageBlock titleBlock;
@property (nonatomic, assign) PAYFormErrorMessageBlock messageBlock;

@end


@implementation PAYFormErrorMessage

+ (instancetype)errorMessageWithTitle:(NSString *)title message:(NSString *)message {
    if (!title && !message) {
        return nil;
    }
    PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage new];
    errorMessage.title = title;
    errorMessage.message = message;
    return errorMessage;
}

+ (instancetype)errorMessageWithError:(NSError *)error {
    return [self errorMessageWithTitle:error.title message:error.message];
}

+ (instancetype)errorMessageWithTitleBlock:(PAYFormErrorMessageBlock)titleBlock messageBlock:(PAYFormErrorMessageBlock)messageBlock {
    PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage new];
    errorMessage.titleBlock = titleBlock;
    errorMessage.messageBlock = messageBlock;
    return errorMessage;
}

- (NSString *)titleForField:(id<PAYValidatableFormCell>)field {
    if (self.titleBlock) {
        self.title = self.titleBlock(field);
    }
    if (field && [self.title rangeOfString:@"%@"].location != NSNotFound) {
        return [NSString stringWithFormat:self.title, field.name];
    }
    return self.title;
}

- (NSString *)messageForField:(id<PAYValidatableFormCell>)field {
    if (self.messageBlock) {
        self.message = self.messageBlock(field);
    }
    if (field && [self.message rangeOfString:@"%@"].location != NSNotFound) {
        return [NSString stringWithFormat:self.message, field.name];
    }
    return self.message;
}

@end