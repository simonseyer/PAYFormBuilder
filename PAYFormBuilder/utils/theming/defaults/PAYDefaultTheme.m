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
        self.font         = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.subTitleFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    }
    return self;
}

@end
