//
//  PAYStyle.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYStyle.h"
#import "PAYDefaultSectionTheme.h"
#import "PAYDefaultTableTheme.h"
#import "PAYDefaultLabelThemeContainer.h"

@implementation PAYStyle

static id<PAYSectionTheme> _sectionTheme;
static id<PAYTableTheme> _tableTheme;
static id<PAYLabelThemeContainer> _labelTheme;

+ (id<PAYSectionTheme>)sectionTheme {
    if (!_sectionTheme) {
        _sectionTheme = [PAYDefaultSectionTheme new];
    }
    return _sectionTheme;
}

+ (void)setSectionTheme:(id<PAYSectionTheme>)theme {
    _sectionTheme = theme;
}

+ (id<PAYTableTheme>)tableTheme {
    if (!_tableTheme) {
        _tableTheme = [PAYDefaultTableTheme new];
    }
    return _tableTheme;
}

+ (void)setTableTheme:(id<PAYTableTheme>)theme {
    _tableTheme = theme;
}

+ (id<PAYLabelThemeContainer>)labelTheme {
    if (!_labelTheme) {
        _labelTheme = [PAYDefaultLabelThemeContainer new];
    }
    return _labelTheme;
}

+ (void)setLabelTheme:(id<PAYLabelThemeContainer>)theme {
    _labelTheme = theme;
}

@end
