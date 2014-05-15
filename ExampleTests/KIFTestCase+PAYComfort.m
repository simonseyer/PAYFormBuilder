//
//  KIFTestCase+PAYComfort.m
//  Example
//
//  Created by Simon Seyer on 15.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "KIFTestCase+PAYComfort.h"
#import <KIF/UIAccessibilityElement-KIFAdditions.h>

@implementation KIFTestCase (PAYComfort)

- (BOOL)findViewWithLabel:(NSString*)label {
    UIView *view = nil;
    return [UIAccessibilityElement accessibilityElement:NULL view:&view withLabel:label value:nil traits:UIAccessibilityTraitNone tappable:NO error:nil];
}

@end
