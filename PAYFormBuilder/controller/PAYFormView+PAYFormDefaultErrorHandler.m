//
//  PAYFormView+PAYFormDefaultErrorHandler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView+PAYFormDefaultErrorHandler.h"

@implementation PAYFormView (PAYFormDefaultErrorHandler)

static char fieldErrorMessages;
static char classErrorMessages;

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self.class, &classErrorMessages);
    if (!errorMessages) {
        errorMessages = [NSMutableDictionary new];
        objc_setAssociatedObject(self.class, &classErrorMessages, errorMessages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [errorMessages setObject:errorMessage forKey:[NSNumber numberWithInt:code]];
}

+ (PAYFormErrorMessage *)classErrorMessageForErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self.class, &classErrorMessages);
    if (!errorMessages) {
        return  nil;
    }
    return [errorMessages objectForKey:[NSNumber numberWithInt:code]];
}

- (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self, &fieldErrorMessages);
    if (!errorMessages) {
        errorMessages = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &fieldErrorMessages, errorMessages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [errorMessages setObject:errorMessage forKey:[NSNumber numberWithInt:code]];
}

- (PAYFormErrorMessage *)fieldErrorMessageForErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self, &fieldErrorMessages);
    if (!errorMessages) {
        return  nil;
    }
    return [errorMessages objectForKey:[NSNumber numberWithInt:code]];
}

- (PAYFormErrorMessage *)errorMessageForErrorCode:(NSUInteger)code {
    PAYFormErrorMessage *errorMessage = [self fieldErrorMessageForErrorCode:code];
    if (!errorMessage) {
        errorMessage = [self.class classErrorMessageForErrorCode:code];
    }
    return errorMessage;
}

@end
