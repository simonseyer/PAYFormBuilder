//
//  PAYFormSectionBuilder.h
//  paij
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"

@interface PAYFormSectionBuilder : NSObject <PAYSectionBuilder>

@property (nonatomic, retain) PAYFormSection *section;
@property (nonatomic, assign) CGRect defaultBounds;

- (id)initWithFormSection:(PAYFormSection *)section defaultCellBounds:(CGRect)defaultBounds;

+ (UILabel *)defaultLabelInRect:(CGRect)defaultBounds;
+ (UITextField *)defaultTextField;
+ (UITextView *)defaultTextView;

@end
