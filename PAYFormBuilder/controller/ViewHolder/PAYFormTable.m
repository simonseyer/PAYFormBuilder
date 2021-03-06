//
//  PAYFormTable.m
//  PAYFormBuilder
//
//  Created by Marius Rackwitz on 18.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTable.h"
#import "PAYFormField.h"
#import "PAYFormView_protected.h"
#import "NSError+PAYComfort.h"
#import "PAYFormDefaultErrorHandler.h"
#import "PAYFormDefaultErrorHandler_protected.h"


@implementation PAYFormTable

- (id)init {
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray new];
        __weak PAYFormTable *weakSelf = self;
        self.completionBlock = ^{
            PAYFormTable *strongSelf = weakSelf;
            if (strongSelf.finishOnLastField) {
                [strongSelf validate];
            }
        };
        self.formFailBlock = PAYFormDefaultErrorHandler.failBlock;
    }
    return self;
}

- (void)validate {
    NSError *error = [self doValidate];
    if (!error) {
        if (self.formSuccessBlock) {
            self.formSuccessBlock();
        }
    } else {
        if ((!self.formFailBlock || !self.formFailBlock(error)) && error.field) {
            [error.field styleForError:error];
        }
    }
}

- (NSError *)doValidate {
    for (PAYFormSection *section in self.sections) {
        NSError *error = [section validate];
        if (error) {
            return error;
        }
    }
    if (self.validationBlock) {
        return self.validationBlock();
    }
    return nil;
}

- (void)initSectionJumpOrder {
    PAYFormSection *previousSection;
    for (PAYFormSection *section in self.sections.reverseObjectEnumerator) {
        BOOL sectionWithActiveField = [section initFieldJumpOrderWithNextSection:previousSection];
        
        if (sectionWithActiveField) {
            if (!previousSection) {
                // Let last section execute the table's completion block
                __weak PAYFormTable *weakSelf = self;
                section.completionBlock = ^{
                    PAYFormTable *strongSelf = weakSelf;
                    if (strongSelf.completionBlock) {
                        strongSelf.completionBlock();
                    }
                };
            }
            
            previousSection = section;
        }
    }
}

@end
