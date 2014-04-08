//
//  PAYFormTable.m
//  paij
//
//  Created by Marius Rackwitz on 18.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormTable.h"
#import "PAYFormField.h"


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
    NSError *error = [self doValidate];
    if (!error) {
        if (self.formSuccessBlock) {
            self.formSuccessBlock();
        }
    } else {
        if (!self.formFailBlock || !self.formFailBlock(error)) {
            id formField = error.userInfo[PAYFormBuilderErrorControlKey];
            if (formField && [formField conformsToProtocol:@protocol(PAYValidatableFormCell)]) {
                PAYFormFieldErrorStylingBlock errorStylingBlock = ((id<PAYValidatableFormCell>)formField).errorStylingBlock;
                if (errorStylingBlock) {
                    errorStylingBlock(formField, error);
                }
            }
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

# pragma mark - Error handling

static PAYFormTableFailBlock formFailBlock = nil;

+ (void)initialize {
    self.formFailBlock = ^BOOL(NSError *error) {
        return NO;
    };
}

+ (PAYFormTableFailBlock)formFailBlock {
    return formFailBlock;
}

+(void)setFormFailBlock:(PAYFormTableFailBlock)block {
    formFailBlock = block;
}

- (PAYFormTableFailBlock)formFailBlock {
    if (_formFailBlock) {
        return formFailBlock;
    }
    return self.class.formFailBlock;
}

@end
