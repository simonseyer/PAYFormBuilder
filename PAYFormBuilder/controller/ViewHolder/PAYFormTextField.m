//
//  PAYFormTextField.m
//  PAYFormBuilder
//
//  Created by Marius Rackwitz on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTextField.h"
#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"
#import "PAYFormField_protected.h"


@interface PAYFormTextField ()

@end


@implementation PAYFormTextField

#pragma mark - Custom validation

- (NSError *)prevalidate {
    NSError *error = [super prevalidate];
    if (error) {
        return error;
    }
    
    NSString *cleanedValue = self.cleanedValue;
    
    if (self.maxTextLength > 0 && cleanedValue.length > self.maxTextLength) {
        return [NSError validationErrorWithCode:PAYFormTextFieldAboveMaxLengthErrorCode control:self];
    }
    
    if (self.minTextLength > 0 && cleanedValue.length < self.minTextLength) {
        return [NSError validationErrorWithCode:PAYFormTextFieldBelowMinLengthErrorCode control:self];
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
        text = [text stringByReplacingOccurrencesOfString:separator withString:@""];
        for (int i=0; i<text.length; i+=groupSize) {
            if (groupIndex + 1 == groupSizes.count) {
                [numberGroups addObject:[text substringWithRange:NSMakeRange(i, text.length-i)]];
                break;
            }
            groupSize = [groupSizes[groupIndex++] intValue];
            [numberGroups addObject:[text substringWithRange:NSMakeRange(i, MIN(groupSize, text.length-i))]];
        }
        return [numberGroups componentsJoinedByString:separator];
    };
}

@end
