//
//  PAYFormSection.m
//  paij
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormSection.h"
#import "PAYFormField.h"
#import "PAYFormButton.h"


@implementation PAYFormSection

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
            if (formField.control.isEnabled) {
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
            if (formField.control.isEnabled) {
                return row;
            }
        }
    }
    return nil;
}

- (PAYFormField *)firstFormField {
    if (!_firstFormField) {
        _firstFormField = [self findFirstFormField];
    }
    return _firstFormField;
}

- (NSError *)validate {
    for (id<PAYFormRow> row in self.views) {
        if ([row conformsToProtocol:@protocol(PAYValidatableFormCell)]) {
            id<PAYValidatableFormCell> validatableCell = (id<PAYValidatableFormCell>)row;
            [validatableCell styleForError:nil];
            NSError *error = [validatableCell validate];
            if (error) {
                return error;
            }
        }
    }
    return nil;
}

@end
