//
//  PAYFormButtonGroup.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"

@interface PAYFormButtonGroup : NSObject <PAYValidatableFormCell>

@property (nonatomic, weak) PAYFormSection *section;

@property (nonatomic, assign) BOOL multiSelection;
@property (nonatomic, assign) BOOL isRequired;

@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, retain, readonly) NSArray *values;
@property (nonatomic, retain, readonly) id value;

- (void)optionStateChanged:(id)option;
- (void)select:(BOOL)select value:(id)value;
- (void)select:(id)value;

@end
