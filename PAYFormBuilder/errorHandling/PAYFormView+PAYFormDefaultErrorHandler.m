//
//  PAYFormView+PAYFormDefaultErrorHandler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView+PAYFormDefaultErrorHandler.h"
#import "PAYFormView+PAYFormDefaultErrorHandlerProtected.h"

@implementation PAYFormView (PAYFormDefaultErrorHandler)

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = self.classErrorMessages;
    if (!errorMessages) {
        errorMessages = [NSMutableDictionary new];
        self.classErrorMessages = errorMessages;
    }
    errorMessages[@(code)] = errorMessage;
}

- (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    NSMutableDictionary *errorMessages = self.fieldErrorMessages;
    if (!errorMessages) {
        errorMessages = [NSMutableDictionary new];
        self.fieldErrorMessages = errorMessages;
    }
    errorMessages[@(code)] = errorMessage;
}

@end
