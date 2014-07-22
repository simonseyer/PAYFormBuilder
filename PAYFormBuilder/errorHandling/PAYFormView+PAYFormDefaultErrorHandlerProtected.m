//
//  PAYFormView+PAYFormDefaultErrorHandlerProtected.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView+PAYFormDefaultErrorHandlerProtected.h"
#import <libextobjc/extobjc.h>

@implementation PAYFormView (PAYFormDefaultErrorHandlerProtected)

+ (NSMutableDictionary *)classErrorMessages {
    return objc_getAssociatedObject(self.class, @selector(classErrorMessages));
}

+ (void)setClassErrorMessages:(NSMutableDictionary *)errorMessages {
    objc_setAssociatedObject(self.class, @selector(classErrorMessages), errorMessages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)fieldErrorMessages {
    return objc_getAssociatedObject(self, @selector(fieldErrorMessages));
}

- (void)setFieldErrorMessages:(NSMutableDictionary *)errorMessages {
    objc_setAssociatedObject(self, @selector(fieldErrorMessages), errorMessages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (PAYFormErrorMessage *)classErrorMessageForErrorCode:(NSUInteger)code {
    // This category could be used on all subclasses of PAYFormView. So it has to be checked,
    // if one of the super classes of the current class has an error message for the error,
    // if the current class could not offer one.
    Class curClass = self.class;
    PAYFormErrorMessage *errorMessage = nil;
    while (!errorMessage && [curClass isSubclassOfClass:PAYFormView.class]) {
        NSMutableDictionary *errorMessages = curClass.classErrorMessages;
        if (errorMessages) {
            errorMessage = errorMessages[@(code)];
        }
        curClass = curClass.superclass;
    }
    return errorMessage;
}

- (PAYFormErrorMessage *)fieldErrorMessageForErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = self.fieldErrorMessages;
    if (!errorMessages) {
        return  nil;
    }
    return errorMessages[@(code)];
}

- (PAYFormErrorMessage *)errorMessageForErrorCode:(NSUInteger)code {
    PAYFormErrorMessage *errorMessage = [self fieldErrorMessageForErrorCode:code];
    if (!errorMessage) {
        errorMessage = [self.class classErrorMessageForErrorCode:code];
    }
    return errorMessage;
}

@end
