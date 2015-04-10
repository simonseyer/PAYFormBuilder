//
//  PAYDefaultTableTheme.m
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import "PAYDefaultTableTheme.h"

@implementation PAYDefaultTableTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.labelStyleNoneHeight  = 32.0f;
        self.labelStyleEmptyHeight = 36.0f;
        self.infoIconMargin        = 6.0f;
    }
    return self;
}

@end
