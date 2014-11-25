//
//  PAYErrorMessageManager.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 25.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormErrorMessageManager.h"
#import "PAYFormErrorMessage.h"
#import "NSError+PAYComfort.h"
#import "PAYFormView.h"
#import "PAYFormView+PAYFormDefaultErrorHandlerProtected.h"

@implementation PAYFormErrorMessageManager

static NSMutableDictionary *errorMessages;
+ (void)initialize {
    errorMessages = [NSMutableDictionary new];
}

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    errorMessages[@(code)] = errorMessage;
}

+ (PAYFormErrorMessage *)errorMessageForError:(NSError *)error {
    PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage errorMessageWithError:error];
    if (!errorMessage) {
        if ([error.field isKindOfClass:PAYFormView.class]) {
            errorMessage = [(PAYFormView *)error.field errorMessageForErrorCode:error.code];
        }
    }
    if (!errorMessage) {
        errorMessage = errorMessages[@(error.code)];
    }
    return errorMessage;
}

@end
