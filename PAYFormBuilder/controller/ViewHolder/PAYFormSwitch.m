//
//  PAYFormToggle.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSwitch.h"
#import "NSError+PAYComfort.h"


@implementation PAYFormSwitch


-(void)styleForError:(NSError *)error {
    if (error) {
        UIColor *redColor = [UIColor colorFromHex:0xFFFF3B30];
        self.label.textColor = redColor;
    } else {
        UIColor *defaultColor = [UIColor colorFromHex:0xFF323232];
        self.label.textColor = defaultColor;
    }
}

-(NSError *)validate {
    if (self.isRequired && !self.switchControl.isOn) {
        return [NSError validationErrorWithCode:PAYFormMissingErrorCode control:self];
    }
    return nil;
}

- (NSString *)name {
    return self.label.text;
}

- (BOOL)value {
    return self.switchControl.isOn;
}

- (void)setValue:(BOOL)value {
    self.switchControl.on = value;
}

@end
