//
//  PAYFormButton.m
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormButton.h"


@interface PAYFormButton ()

@property (nonatomic, retain) UIColor *titleColorBackup;

@end


@implementation PAYFormButton

- (void)didSelectRow {
    if (self.selectionBlock) {
        self.selectionBlock(self);
    }
}

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.titleLabel.textColor = self.titleColorBackup ? self.titleColorBackup : [UIColor colorFromHex:0xFF323232];
    } else {
        self.titleColorBackup     = self.titleLabel.textColor;
        self.titleLabel.textColor = [UIColor colorFromHex:0xFF898989];
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
