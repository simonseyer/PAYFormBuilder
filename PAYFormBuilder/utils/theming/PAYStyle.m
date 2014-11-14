//
//  PAYStyle.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYStyle.h"
#import "PAYDefaultTheme.h"

@implementation PAYStyle

static id<PAYTheme> _theme;

+ (id<PAYTheme>)theme {
    if (!_theme) {
        _theme = [PAYDefaultTheme new];
    }
    return _theme;
}

+ (void)setTheme:(id<PAYTheme>)theme {
    _theme = theme;
}

@end
