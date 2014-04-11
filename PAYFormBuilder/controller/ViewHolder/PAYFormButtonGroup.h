//
//  PAYFormButtonGroup.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"

@interface PAYFormButtonGroup : NSObject

@property (nonatomic, weak) PAYFormSection *section;
@property (nonatomic, assign) BOOL multiSelection;

@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, retain) NSArray *selectedOptions;

- (void)optionStateChanged:(id)option;
- (void)select:(BOOL)select value:(id)value;
- (void)select:(id)value;

@end
