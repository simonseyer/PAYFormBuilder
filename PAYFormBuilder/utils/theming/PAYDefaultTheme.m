//
//  PAYDefaultTheme.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYDefaultTheme.h"

@implementation PAYDefaultTheme

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fontName         = @"HelveticaNeue-Light";
        self.subTitleFontName = @"HelveticaNeue";
        self.fontSize         = 17.0f;
    }
    return self;
}

@end
