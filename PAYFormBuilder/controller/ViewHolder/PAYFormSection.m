//
//  PAYFormSection.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSection.h"
#import "PAYFormField.h"
#import "PAYFormButton.h"
#import "PAYFormView_protected.h"
#import "PAYFormField_protected.h"
#import <libextobjc/extobjc.h>


@implementation PAYFormSection

@synthesize name = _name;

- (id)init {
    self = [super init];
    if (self) {
        self.views = [NSMutableArray new];
        self.attachedObjects = [NSMutableArray new];
    }
    return self;
}

- (BOOL)initFieldJumpOrderWithNextSection:(PAYFormSection *)section {
    PAYFormField *previousField = nil;
    for (id row in self.views.reverseObjectEnumerator) {
        if ([row isKindOfClass:PAYFormField.class]) {
            PAYFormField *formField = row;
            if (formField.isEnabled) {
                if (!previousField) {
                    @weakify(self);
                    formField.completionBlock = ^{
                        @strongify(self);
                        if (self.completionBlock) {
                            self.completionBlock();
                        }
                    };
                    
                    if (section) {
                        formField.nextFormField = section.firstFormField;
                    }
                } else {
                    formField.nextFormField = previousField;
                }
                previousField = row;
            }
        }
    }
    return previousField != nil;
}

- (PAYFormField *)findFirstFormField {
    for (id row in self.views) {
        if ([row isKindOfClass:PAYFormField.class]) {
            PAYFormField *formField = (PAYFormField *)row;
            if (formField.isEnabled) {
                return row;
            }
        }
    }
    return nil;
}

- (PAYFormField *)firstFormField {
    if (!_firstFormField) {
        _firstFormField = self.findFirstFormField;
    }
    return _firstFormField;
}

- (NSError *)validate {
    NSError *error;
    for (id<PAYFormRow> row in [self.views arrayByAddingObjectsFromArray:self.attachedObjects]) {
        if ([row conformsToProtocol:@protocol(PAYValidatableFormCell)]) {
            id<PAYValidatableFormCell> validatableCell = (id<PAYValidatableFormCell>)row;
            [validatableCell styleForError:nil];
            NSError *fieldError = [validatableCell validate];
            if (!error && fieldError) {
                error = fieldError;
            }
        }
    }
    return error;
}

@end
