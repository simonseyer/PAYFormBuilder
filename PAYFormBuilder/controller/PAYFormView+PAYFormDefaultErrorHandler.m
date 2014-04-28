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
    [errorMessages setObject:errorMessage forKey:[NSNumber numberWithUnsignedLong:code]];
}

+ (PAYFormErrorMessage *)classErrorMessageForErrorCode:(NSUInteger)code {
    // This category could be used on all subclasses of PAYFormView. So it has to be checked,
    // if one of the super classes of the current class has an error message for the error,
    // if the current class could not offer one.
    Class curClass = self.class;
    NSMutableDictionary *errorMessages = nil;
    while (!errorMessages && [curClass isSubclassOfClass:PAYFormView.class]) {
        errorMessages = objc_getAssociatedObject(curClass, &classErrorMessages);
        curClass = curClass.superclass;
    }
    if (!errorMessages) {
        return  nil;
    }
    return [errorMessages objectForKey:[NSNumber numberWithUnsignedLong:code]];
}

- (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self, &fieldErrorMessages);
    if (!errorMessages) {
        errorMessages = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &fieldErrorMessages, errorMessages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [errorMessages setObject:errorMessage forKey:[NSNumber numberWithUnsignedLong:code]];
}

- (PAYFormErrorMessage *)fieldErrorMessageForErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = objc_getAssociatedObject(self, &fieldErrorMessages);
    if (!errorMessages) {
        return  nil;
    }
    return [errorMessages objectForKey:[NSNumber numberWithUnsignedLong:code]];
}

- (PAYFormErrorMessage *)errorMessageForErrorCode:(NSUInteger)code {
    PAYFormErrorMessage *errorMessage = [self fieldErrorMessageForErrorCode:code];
    if (!errorMessage) {
        errorMessage = [self.class classErrorMessageForErrorCode:code];
    }
    return errorMessage;
}

@end
