//
//  UITableViewCell+ScrollInset.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 02.12.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "UITableViewCell+ScrollInset.h"
#import <objc/runtime.h>


@implementation UITableViewCell (ScrollInset)

- (UIEdgeInsets)scrollInsets {
    NSValue *nsvalue = objc_getAssociatedObject(self, @selector(scrollInsets));
    UIEdgeInsets insets;
    [nsvalue getValue:&insets];
    return insets;
}

- (void)setScrollInsets:(UIEdgeInsets)scrollInsets {
    NSValue *nsvalue = [NSValue valueWithBytes:&scrollInsets objCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(scrollInsets), nsvalue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
