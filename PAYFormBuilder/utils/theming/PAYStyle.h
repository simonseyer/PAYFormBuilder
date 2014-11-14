//
//  PAYStyle.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYTheme.h"

@interface PAYStyle : NSObject

+ (id<PAYTheme>)theme;
+ (void)setTheme:(id<PAYTheme>)theme;

@end
