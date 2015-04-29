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

- (void)setCell:(UITableViewCell *)cell {
    _cell = cell;
    _view = cell.contentView;
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
