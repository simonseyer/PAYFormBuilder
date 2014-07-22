//
//  PAYFormView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYFormView_protected.h"
#import "UIColor+PAYHex.h"
#import "PAYNotifications.h"


@implementation PAYFormView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.defaultErrorColor = [UIColor colorFromHex:0xFFFF3B30];
        self.defaultTextColor  = [UIColor colorFromHex:0xFF323232];
    }
    return self;
}

- (BOOL)becomeFirstResponder {
    [[NSNotificationCenter defaultCenter]postNotificationName:PAYFormRowFocusRequestNotification object:self.view];
    // Refuse first responder status, as no concrete replacement implementation was preferred.
    return NO;
}

- (void)didSelectRow {
    // Stub
}

@end
