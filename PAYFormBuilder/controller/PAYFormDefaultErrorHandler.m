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

- (void)replacePlaceholder:(NSString *)replaceString {
    if ([self.title rangeOfString:@"%@"].location != NSNotFound) {
        self.title = [NSString stringWithFormat:self.title, replaceString];
    }
    
    if ([self.message rangeOfString:@"%@"].location != NSNotFound) {
        self.message = [NSString stringWithFormat:self.message, replaceString];
    }
}

@end


@implementation PAYFormDefaultErrorHandler

static NSMutableDictionary *texts;
+ (void)initialize {
    texts = [NSMutableDictionary new];
}

+ (void)setTitle:(NSString *)title message:(NSString *)message forErrorCode:(NSUInteger)code {
    [texts setObject:[PAYFormErrorMessage errorMessageWithTitle:title message:message] forKey:[NSNumber numberWithInt:code]];
}

+ (void)setErrorMessageBlock:(PAYFormErrorMessageBlock)messageBlock forErrorCode:(NSUInteger)code {
    [texts setObject:messageBlock forKey:[NSNumber numberWithInt:code]];
}

+ (PAYFormTableFailBlock)failBlock {
    return ^BOOL(NSError *error) {
        
        PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage errorMessageWithError:error];
        if (!errorMessage) {
            id predefinedText = [texts objectForKey:[NSNumber numberWithInt:error.code]];
            if ([predefinedText isKindOfClass:PAYFormErrorMessage.class]){
                errorMessage = predefinedText;
            } else {
                errorMessage = ((PAYFormErrorMessageBlock)predefinedText)(error.field);
            }
        }
        [errorMessage replacePlaceholder:error.field.name];
        
        UIAlertView* alertView = [UIAlertView bk_alertViewWithTitle:errorMessage.title message:errorMessage.message];
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
