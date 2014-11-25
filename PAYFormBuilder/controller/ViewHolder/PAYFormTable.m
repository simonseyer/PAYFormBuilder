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
#import <BlocksKit+UIKit.h>
#import <libextobjc/extobjc.h>
#import "PAYFormDefaultErrorHandler.h"


@implementation PAYFormTable

- (id)init {
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray new];
        @weakify(self);
        self.completionBlock = ^{
            @strongify(self);
            if (self.finishOnLastField) {
                [self validate];
            }
        };
    }
    return self;
}

- (void)validate {
    NSArray *errors = [self doValidate];
    if (!errors.count) {
        if (self.formSuccessBlock) {
            self.formSuccessBlock();
        }
    } else {
        [self.errorDelegate handleErrors:errors];
    }
}

- (NSArray *)doValidate {
    NSMutableArray *errors = [NSMutableArray new];
    for (PAYFormSection *section in self.sections) {
        [errors addObjectsFromArray:[section validate]];
    }
    if (self.validationBlock) {
        NSError *validationError = self.validationBlock();
        if (validationError) {
            [errors addObject:validationError];
        }
    }
    return errors;
}

- (void)initSectionJumpOrder {
    PAYFormSection *previousSection;
    for (PAYFormSection *section in self.sections.reverseObjectEnumerator) {
        BOOL sectionWithActiveField = [section initFieldJumpOrderWithNextSection:previousSection];
        
        if (sectionWithActiveField) {
            if (!previousSection) {
                // Let last section execute the table's completion block
                @weakify(self);
                section.completionBlock = ^{
                    @strongify(self);
                    if (self.completionBlock) {
                        self.completionBlock();
                    }
                };
            }
            
            previousSection = section;
        }
    }
}

@end
