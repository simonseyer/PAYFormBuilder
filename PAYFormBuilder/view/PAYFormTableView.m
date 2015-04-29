//
//  PAYFormTableView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 07.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTableView.h"
#import "PAYStyle.h"

@implementation PAYFormTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeVariables];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeVariables];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeVariables];
    }
    return self;
}

- (void)initializeVariables {
    // Apply default style
    self.backgroundColor     = PAYStyle.tableTheme.backgroundColor;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.sectionFooterHeight = 0.0;
}

@end
