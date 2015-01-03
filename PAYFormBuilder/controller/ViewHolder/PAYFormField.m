//
//  PAYFormField.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormField.h"
#import "PAYFormField_protected.h"
#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"


@implementation PAYFormField

- (NSString *)name {
    return @"";
}

- (PAYFormFieldCleanBlock)cleanBlock {
    if (!_cleanBlock) {
        return ^(PAYFormField *formField, id value){
            return value;
        };
    }
    return _cleanBlock;
}

#pragma mark - Field jump implementation

- (UIView<PAYFormControl> *)nextEnabledControl {
    return self.nextFormField.ownOrNextEnabledControl;
}

- (UIView<PAYFormControl> *)ownOrNextEnabledControl {
    if (self.isEnabled) {
        return self.control;
    } else {
        return self.nextEnabledControl;
    }
}

- (void)jumpToNextField {
    [self.nextEnabledControl becomeFirstResponder];
}


#pragma mark - Validation

- (NSError *)validate {
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

- (NSError *)validationErrorWithTitle:(NSString *)title message:(NSString *)message {
    return [NSError validationErrorWithTitle:title message:message control:self];
}

- (NSError *)validationErrorWithCode:(NSUInteger)code {
    return [NSError validationErrorWithCode:code control:self];
}

- (NSError *)prevalidate {
    if (self.required && self.isEmpty) {
        return [NSError validationErrorWithCode:PAYFormMissingErrorCode control:self];
    }
    return nil;
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

- (void)styleForError:(NSError *)error {
    
}

@end
