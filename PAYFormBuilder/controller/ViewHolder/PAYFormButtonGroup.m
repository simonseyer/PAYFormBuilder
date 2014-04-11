//
//  PAYFormButtonGroup.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButtonGroup.h"
#import "PAYFormButton.h"

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

- (void)optionStateChanged:(id)option {
    PAYFormButton *formButton = self.options[option];
    [self select:!formButton.selected value:option];
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
        if (self.selectedOption == value) {
            return;
        }
        
        [self selectButton:NO withValue:self.selectedOption];
        [_selectedOptions removeObject:self.selectedOption];
        
        [self selectButton:YES withValue:value];
        [_selectedOptions addObject:value];
    }
}

- (void)select:(id)value {
    [self select:YES value:value];
}

- (id)selectedOption {
    return _selectedOptions.firstObject;
}

- (void)selectButton:(BOOL)select withValue:(id)value {
    PAYFormButton *formButton = self.options[value];
    formButton.selected = select;
}

@end
