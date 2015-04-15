//
//  PAYFormButtonGroup.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButtonGroup.h"
#import "PAYFormButtonGroup_protected.h"
#import "PAYFormButton.h"
#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"


@interface PAYFormButtonGroup ()

@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSMutableArray *optionButtons;

@end


@implementation PAYFormButtonGroup {
    NSMutableArray *_selectedOptions;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.options = [NSMutableArray new];
        self.optionButtons = [NSMutableArray new];
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

- (void)setValue:(id)value {
    [self select:value];
}

- (void)select:(id)value {
    [self select:YES value:value];
}

- (NSError *)validate {
    if (self.required && _selectedOptions.count == 0) {
        return [NSError validationErrorWithCode:PAYFormMissingErrorCode
                                        control:self];
    }
    return nil;
}

- (void)styleForError:(NSError *)error {
    
}

- (void)addButton:(PAYFormButton *)button forValue:(id)value {
    @synchronized(self) {
        [self.options addObject: value];
        [self.optionButtons addObject:button];
    }
}

- (PAYFormButton *)buttonForValue:(id)value {
    if (!value) {
        return nil;
    }
    PAYFormButton *formButton;
    @synchronized(self) {
        NSInteger index = [self.options indexOfObject:value];
        if (index != NSNotFound) {
            formButton = self.optionButtons[index];
        }
    }
    return formButton;
}

- (void)select:(BOOL)select value:(id)value {
    [self willChangeValueForKey:@"value"];
    PAYFormButton *formButton = [self buttonForValue:value];
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
    [self didChangeValueForKey:@"value"];
}

- (void)optionStateChanged:(id)option {
    PAYFormButton *formButton = [self buttonForValue:option];
    [self select:!formButton.selected value:option];
}

- (void)selectButton:(BOOL)select withValue:(id)value {
    PAYFormButton *formButton = [self buttonForValue:value];
    formButton.selected = select;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)theKey {
    if ([theKey isEqualToString:@"value"]) {
        return NO;
    } else {
        return [super automaticallyNotifiesObserversForKey:theKey];
    }
}

@end
