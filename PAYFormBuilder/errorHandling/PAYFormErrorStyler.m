//
//  PAYFormErrorStyler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 25.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormErrorStyler.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormMultiLineTextField.h"
#import "PAYFormSwitch.h"
#import <libextobjc/extobjc.h>

@implementation PAYFormErrorStyler

- (void)styleField:(id<PAYValidatableFormCell>)field {
    // Call the correct style method for the field type
    NSString *selectorName = [NSString stringWithFormat:@"style%@:", field.class];
    
    SEL s = NSSelectorFromString(selectorName);
    if ([self respondsToSelector:s]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:s withObject:field];
#pragma clang diagnostic pop
    }
}

- (void)stylePAYFormSingleLineTextField:(PAYFormSingleLineTextField *)formField {
    formField.textField.textColor = formField.defaultErrorColor;
    formField.label.textColor     = formField.defaultErrorColor;
    
    @weakify(formField);
    formField.validationResetBlock = ^{
        @strongify(formField);
        formField.textField.textColor = formField.defaultTextColor;
        formField.label.textColor     = formField.defaultTextColor;
    };
}

- (void)stylePAYFormMultiLineTextField:(PAYFormMultiLineTextField *)formField {
    formField.textView.textColor = formField.defaultErrorColor;
    
    @weakify(formField);
    formField.validationResetBlock = ^{
        @strongify(formField);
        formField.textView.textColor = formField.defaultTextColor;
    };
}

- (void)stylePAYFormSwitch:(PAYFormSwitch *)formField {
    formField.label.textColor = formField.defaultErrorColor;
    
    @weakify(formField);
    formField.validationResetBlock = ^{
        @strongify(formField);
        formField.label.textColor = formField.defaultTextColor;
    };
}


@end
