//
//  PAYFormButton.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButton.h"
#import "PAYFormButton_protected.h"
#import "PAYStyle.h"

@implementation PAYFormButton

- (void)didSelectRow {
    if (self.selectionBlock) {
        self.selectionBlock(self);
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        if (PAYStyle.sectionTheme.checkmarkAccessoryViewProviderBlock) {
            self.cell.accessoryView = PAYStyle.sectionTheme.checkmarkAccessoryViewProviderBlock();
        }
        self.cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.cell.accessoryView = nil;
        self.cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
