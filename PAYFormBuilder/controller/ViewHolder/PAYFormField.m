//
//  PAYFormField.m
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormField.h"
#import "PAYformBuilder.h"


NSString *const PAYFormFieldErrorDomain = @"PAYFormFieldErrorDomain";


@implementation PAYFormField

@synthesize errorStylingBlock;

- (NSString *)name {
    return self.section.header.label.text;
}

- (PAYFormFieldCleanBlock)cleanBlock {
    if (!_cleanBlock) {
        return ^(PAYFormField *formField, id value){
            return value;
        };
    }
    return _cleanBlock;
}

- (BOOL)becomeFirstResponder {
    // Refuse first responder status, as no concrete replacement implementation was preferred.
    return NO;
}

#pragma mark - Field jump implementation

- (UIView<PAYFormControl> *)nextEnabledControl {
    return self.nextFormField.ownOrNextEnabledControl;
}

- (UIView<PAYFormControl> *)ownOrNextEnabledControl {
    if (self.control.isEnabled) {
        return self.control;
    } else {
        return self.nextEnabledControl;
    }
}

- (void)jumpToNextField {
    [self.nextEnabledControl becomeFirstResponder];
}


#pragma mark - Validation

- (NSError *)missingError {
    if (!_missingError) {
        return [PAYFormField validationErrorWithTitle:NSLocalizedStringFromTable(@"errorXIsMissingTitle", @"PAYFormBuilder", nil)
                                              message:NSLocalizedStringFromTable(@"errorXIsMissingReason", @"PAYFormBuilder", nil)];
        //NSLocalizedRecoverySuggestionErrorKey: NSLocalizedStringFromTable(@"errorXIsMissingSuggestion", @"PAYFormBuilder", nil)
    }
    return _missingError;
}

- (NSError *)validate {
    [self reset];
    self.error = [self doValidate];
    return self.error;
}

- (NSError *)doValidate {
    NSError *error = [self prevalidate];
    if (error) {
        return error;
    }
    
    if (self.validationBlock) {
        NSError *error = self.validationBlock(self);
        if (error) {
            return error;
        }
    }
    
    return nil;
}

+ (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message {
    NSDictionary* userInfo = @{
                                      NSLocalizedDescriptionKey:               title,
                                      NSLocalizedFailureReasonErrorKey:        title,
                                      NSLocalizedRecoverySuggestionErrorKey:   message,
                                      PAYFormBuilderErrorControlKey:           self
    };
    
    return [[NSError alloc] initWithDomain:PAYFormBuilderErrorDomain
                            code:PAYFormBuilderErrorCode
                        userInfo:userInfo];
}

- (NSError *)prevalidate {
    if (self.isRequired && self.isEmpty) {
        return self.missingError;
    }
    return nil;
}

- (void)reset {
    self.error = nil;
}

- (id)value {
    return nil;
}

- (id)cleanedValue {
    return self.cleanBlock(self, self.value);
}

- (BOOL)isEmpty {
    return NO;
}

@end
