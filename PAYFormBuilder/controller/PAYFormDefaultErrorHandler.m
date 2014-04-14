//
//  DefaultErrorHandler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormDefaultErrorHandler.h"
#import <BlocksKit+UIKit.h>
#import "NSError+PAYComfort.h"
#import "PAYFormField.h"
#import "PAYFormView+PAYFormDefaultErrorHandler.h"

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


@implementation PAYFormDefaultErrorHandler

static NSMutableDictionary *errorMessages;
+ (void)initialize {
    errorMessages = [NSMutableDictionary new];
}

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    [errorMessages setObject:errorMessage forKey:[NSNumber numberWithInt:code]];
}

+ (PAYFormTableFailBlock)failBlock {
    return ^BOOL(NSError *error) {
        
        PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage errorMessageWithError:error];
        if (!errorMessage) {
            errorMessage = [error.field errorMessageForErrorCode:error.code];
        }
        if (!errorMessage) {
            errorMessage = [errorMessages objectForKey:[NSNumber numberWithInt:error.code]];
        }
        
        UIAlertView* alertView = [UIAlertView bk_alertViewWithTitle:[errorMessage titleForField:error.field]
                                                            message:[errorMessage messageForField:error.field]];
        [alertView addButtonWithTitle:@"OK"];
        
        alertView.bk_willDismissBlock = ^(UIAlertView * alertView, NSInteger state) {
            if ([error.field isKindOfClass:PAYFormField.class]) {
                [((PAYFormField *)error.field).control becomeFirstResponder];
            }
        };
        
        [alertView show];
        return NO;
    };
}

@end
