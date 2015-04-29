//
//  PAYFormToggle.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSwitch.h"
#import "PAYFormSwitch_protected.h"
#import "NSError+PAYComfort.h"
#import "PAYErrorCodes.h"
#import "PAYStyle.h"

@implementation PAYFormSwitch


-(void)styleForError:(NSError *)error {
    if (error) {
        self.label.textColor = PAYStyle.sectionTheme.errorTextColor;
    } else {
        self.label.textColor = PAYStyle.sectionTheme.textColor;
    }
}

-(NSError *)validate {
    if (self.required && !self.switchControl.isOn) {
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

- (void)setEnabled:(BOOL)enabled {
    self.switchControl.enabled = enabled;
}

- (BOOL)isEnabled {
    return self.switchControl.enabled;
}

@end
