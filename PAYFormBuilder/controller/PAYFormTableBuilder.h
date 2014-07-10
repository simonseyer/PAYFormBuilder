//
//  PAYFormTableBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYTableBuilder.h"

@interface PAYFormTableBuilder : NSObject<PAYTableBuilder>

@property (nonatomic, assign) CGFloat labelStyleNoneDefaultHeight UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat labelStylEmptyDefaultHeight UI_APPEARANCE_SELECTOR;

@property (nonatomic, retain) PAYFormTable *table;
@property (nonatomic, assign) CGRect defaultBounds;

- (id)initWithFormTable:(PAYFormTable *)table;

@end
