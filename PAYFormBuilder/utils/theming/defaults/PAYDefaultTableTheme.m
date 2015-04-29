//
//  PAYDefaultTableTheme.m
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import "PAYDefaultTableTheme.h"
#import "UIColor+PAYHex.h"

@implementation PAYDefaultTableTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font                    = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.subTitleFont            = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.backgroundColor         = [UIColor colorFromHex:0xFFF6F6F7];
        self.rowHeight               = 44.0f;
        self.footerHeight            = 36.0f;
        self.labelStyleNoneHeight    = 32.0f;
        self.labelStyleEmptyHeight   = 36.0f;
        self.infoIconMargin          = 6.0f;
        self.headerIconTopMargin     = 32;
        self.headerTitleTopMargin    = 21;
        self.headerSubTitleTopMargin = 14;
        self.headerTintColor         = [UIColor colorFromHex:0xFF008D79];
    }
    return self;
}

@end
