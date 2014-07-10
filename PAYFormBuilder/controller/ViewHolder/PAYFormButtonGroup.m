//
//  PAYFormButtonGroup.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButtonGroup.h"
#import "PAYFormButton.h"
#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"

@implementation PAYFormButtonGroup {
    NSMutableArray *_selectedOptions;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.options = [NSMutableDictionary new];
        _selectedOptions = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)values {
    return _selectedOptions;
}

- (id)value {
    return self.values.firstObject;
}

- (void)select:(id)value {
    [self select:YES value:value];
}

- (NSError *)validate {
    if (self.isRequired && _selectedOptions.count == 0) {
        return [NSError validationErrorWithCode:PAYFormMissingErrorCode
                                        control:self];
    }
    return nil;
}

- (void)styleForError:(NSError *)error {
    
}

- (NSString *)name {
    return @"";
}

- (void)select:(BOOL)select value:(id)value {
    PAYFormButton *formButton = self.options[value];
    if (self.multiSelection) {
        formButton.selected = select;
        if (select) {
            [_selectedOptions addObject:value];
        } else {
            [_selectedOptions removeObject:value];
        }
    } else {
        if (self.value == value) {
            return;
        }
        
        [self selectButton:NO withValue:self.value];
        [_selectedOptions removeObject:self.value];
        
        [self selectButton:YES withValue:value];
        [_selectedOptions addObject:value];
    }
}

- (void)optionStateChanged:(id)option {
    PAYFormButton *formButton = self.options[option];
    [self select:!formButton.selected value:option];
}

- (void)selectButton:(BOOL)select withValue:(id)value {
    PAYFormButton *formButton = self.options[value];
    formButton.selected = select;
}

@end
