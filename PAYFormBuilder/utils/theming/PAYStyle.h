//
//  PAYStyle.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYTheme.h"
#import "PAYSectionTheme.h"
#import "PAYTableTheme.h"
#import "PAYLabelTheme.h"

@interface PAYStyle : NSObject

+ (id<PAYTheme>)theme;
+ (void)setTheme:(id<PAYTheme>)theme;

+ (id<PAYSectionTheme>)sectionTheme;
+ (void)setSectionTheme:(id<PAYSectionTheme>)theme;

+ (id<PAYTableTheme>)tableTheme;
+ (void)setTableTheme:(id<PAYTableTheme>)theme;

+ (id<PAYLabelThemeContainer>)labelTheme;
+ (void)setLabelTheme:(id<PAYLabelThemeContainer>)theme;

@end
