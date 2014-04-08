//
//  UIColor+PAYHex.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 07.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "UIColor+PAYHex.h"

@implementation UIColor (PAYHex)

+ (UIColor *)colorFromHex:(int)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

@end
