//
//  PAYDefaultTheme.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYTheme.h"

@interface PAYDefaultTheme : NSObject <PAYTheme>

@property (nonatomic, retain) NSString *fontName;
@property (nonatomic, retain) NSString *subTitleFontName;
@property (nonatomic, assign) NSUInteger fontSize;

@end
