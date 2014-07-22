//
//  PAYFormButtonGroupBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormButtonGroupBuilder.h"

@class PAYFormSectionBuilder;
@class PAYFormButtonGroup;

@interface PAYFormButtonGroupBuilder ()

@property (nonatomic, retain) PAYFormButtonGroup *buttonGroup;
@property (nonatomic, retain) PAYFormSectionBuilder *sectionBuilder;

@end