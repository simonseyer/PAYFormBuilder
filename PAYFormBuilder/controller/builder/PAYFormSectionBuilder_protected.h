//
//  PAYFormSectionBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"
#import "PAYFormSectionBuilder.h"

@interface PAYFormSectionBuilder ()

@property (nonatomic, retain) PAYFormSection *section;

- (id)initWithFormSection:(PAYFormSection *)section;

@end
