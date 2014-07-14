//
//  UIColor+PAYHex.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 07.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A color that has an initializer for hex values
 */
@interface UIColor (PAYHex)


/**
 *  Create a new color from a hex value
 *
 *  @param rgbValue the rgb value
 *
 *  @return the corresponding color
 */
+ (UIColor *)colorFromHex:(int)rgbValue;

@end
