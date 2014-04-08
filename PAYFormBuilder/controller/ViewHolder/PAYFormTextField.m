//
//  PAYFormTextField.m
//  paij
//
//  Created by Marius Rackwitz on 14.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormTextField.h"


NSString *const PAYFormTextFieldErrorDomain = @"PAYFormTextFieldErrorDomain";


@interface PAYFormTextField ()

@end


@implementation PAYFormTextField

- (void)setEnabled:(BOOL)enabled {
}


#pragma mark - Style text field

- (void)styleViewsForErroneousState:(BOOL)hasError {
}

#pragma mark - Custom validation

- (void)reset {
    [super reset];
    [self styleViewsForErroneousState:NO];
}

- (NSError *)validate {
    [super validate];
    BOOL hasError = self.error != nil;
    [self styleViewsForErroneousState:hasError];
    return self.error;
}

- (NSError *)prevalidate {
    NSError *error = [super prevalidate];
    if (error) {
        return error;
    }
    
    NSString *cleanedValue = self.cleanedValue;
    
    if (self.maxTextLength > 0 && cleanedValue.length > self.maxTextLength) {
        return [NSError errorWithDomain:PAYFormTextFieldErrorDomain code:PAYFormTextFieldAboveMaxLength userInfo:@{
                                                                                                                   
            NSLocalizedDescriptionKey:             NSLocalizedStringFromTable(@"errorValidationSomethingToLongTitle", @"PAYFormBuilder", nil),
            NSLocalizedFailureReasonErrorKey:      NSLocalizedStringFromTable(@"errorValidationSomethingToLongReason", @"PAYFormBuilder", nil),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedStringFromTable(@"errorXIsMissingSuggestion", @"PAYFormBuilder", nil),
        }];
    }
    
    if (self.minTextLength > 0 && cleanedValue.length < self.minTextLength) {
        return [NSError errorWithDomain:PAYFormTextFieldErrorDomain code:PAYFormTextFieldBelowMinLength userInfo:@{
            NSLocalizedDescriptionKey:              NSLocalizedStringFromTable(@"errorValidationSomethingToShortTitle", @"PAYFormBuilder", nil),
            NSLocalizedFailureReasonErrorKey:       NSLocalizedStringFromTable(@"errorValidationSomethingToShortReason", @"PAYFormBuilder", nil),
            NSLocalizedRecoverySuggestionErrorKey:  NSLocalizedStringFromTable(@"errorXIsMissingSuggestion", @"PAYFormBuilder", nil),
        }];
    }
    
    return nil;
}

- (BOOL)isEmpty {
    return ((NSString *)self.cleanedValue).length == 0;
}

#pragma mark - Format block

- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes {
    [self setFormatTextWithGroupSizes:groupSizes separator:nil];
}

- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes separator:(NSString *)separator {
    self.formatBlock = [self formatBlockWithGroupSizes:groupSizes separator:separator];
}

- (PAYFormFieldFormatBlock)formatBlockWithGroupSizes:(NSArray *)groupSizes separator:(NSString *)separator {
    if (!separator) {
        separator = @" ";
    }
    return ^(PAYFormField *field, NSString *text){
        NSMutableArray* numberGroups = [NSMutableArray new];
        int groupSize=0, groupIndex=0;
        for (int i=0; i<text.length; i+=groupSize) {
            groupSize = [groupSizes[groupIndex++] intValue];
            [numberGroups addObject:[text substringWithRange:NSMakeRange(i, MIN(groupSize, text.length-i))]];
        }
        return [numberGroups componentsJoinedByString:separator];
    };
}

@end
