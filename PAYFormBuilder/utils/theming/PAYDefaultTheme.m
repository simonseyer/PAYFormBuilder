//
//  PAYDefaultTheme.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYDefaultTheme.h"

@implementation PAYDefaultTheme

@synthesize fontName=_fontName, subTitleFontName=_subTitleFontName;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadDefaults];
    }
    return self;
}

- (void)loadDefaults {
    _fontName = @"HelveticaNeue-Light";
    _subTitleFontName = @"HelveticaNeue";
}

@end
