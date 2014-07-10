//
//  PAYFormButtonGroupBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYButtonGroupBuilder.h"

@protocol PAYSectionBuilder;
@class PAYFormButtonGroup;

@interface PAYFormButtonGroupBuilder : NSObject <PAYButtonGroupBuilder>

@property (nonatomic, retain) PAYFormButtonGroup *buttonGroup;
@property (nonatomic, retain) id<PAYSectionBuilder> sectionBuilder;

@end
