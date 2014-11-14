//
//  NSError+PAYComfort.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"

@implementation NSError (PAYComfort)


+ (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message control:(id)control {
    return [[NSError alloc] initWithDomain:PAYFormErrorDomain
                                      code:PAYFormDefaultErrorCode
                                  userInfo:@{
                                             NSLocalizedDescriptionKey:               title,
                                             NSLocalizedFailureReasonErrorKey:        title,
                                             NSLocalizedRecoverySuggestionErrorKey:   message,
                                             PAYFormErrorControlKey:                  control
                                             }];
}

+ (NSError *)validationErrorWithCode:(NSUInteger)code control:(id)control {
    return [[NSError alloc] initWithDomain:PAYFormErrorDomain
                                      code:code
                                  userInfo:@{PAYFormErrorControlKey: control}];
}

- (NSString *)title {
    return self.localizedFailureReason;
}

- (NSString *)message {
    return self.localizedRecoverySuggestion;
}

- (id<PAYValidatableFormCell>)field {
    if ([self.userInfo[PAYFormErrorControlKey] conformsToProtocol:@protocol(PAYValidatableFormCell)]) {
        return self.userInfo[PAYFormErrorControlKey];
    }
    return nil;
}

@end
