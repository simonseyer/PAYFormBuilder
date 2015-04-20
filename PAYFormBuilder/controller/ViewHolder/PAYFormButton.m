//
//  PAYFormButton.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButton.h"
#import "PAYFormButton_protected.h"


@interface PAYFormButton ()

@end


@implementation PAYFormButton

- (void)didSelectRow {
    if (self.selectionBlock) {
        self.selectionBlock(self);
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
