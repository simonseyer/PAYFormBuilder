//
//  PAYFormTableBuilder.h
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormTable.h"
#import "PAYFormBuilder.h"


@interface PAYFormTableBuilder : NSObject<PAYTableBuilder>

@property (nonatomic, retain) PAYFormTable *table;
@property (nonatomic, assign) CGRect defaultBounds;

- (id)initWithFormTable:(PAYFormTable *)table;

@end
