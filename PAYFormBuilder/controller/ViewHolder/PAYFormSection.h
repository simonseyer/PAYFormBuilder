//
//  PAYFormSection.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormTableViewController.h"
#import "PAYFormHeader.h"


typedef void(^PAYFormSectionCompletionBlock)();


@class PAYFormField;
@class PAYFormButton;


@interface PAYFormSection : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) PAYFormHeader *header;
@property (nonatomic, retain) NSMutableArray *views;
@property (nonatomic, retain) NSMutableArray *attachedObjects;

@property (nonatomic, weak) PAYFormField *firstFormField;
@property (nonatomic, copy) PAYFormSectionCompletionBlock completionBlock;

- (BOOL)initFieldJumpOrderWithNextSection:(PAYFormSection *)section;
- (PAYFormField *)firstFormField;

- (NSError *)validate;

@end
