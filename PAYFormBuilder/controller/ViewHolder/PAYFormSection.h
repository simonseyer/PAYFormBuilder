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


typedef void(^PAYFormSectionCompletionBlock)(void);


@class PAYFormField;
@class PAYFormButton;


@interface PAYFormSection : NSObject

@property (nonatomic, retain, nullable) NSString *name;
@property (nonatomic, retain, nonnull) PAYFormHeader *header;
@property (nonatomic, retain, nonnull) NSMutableArray *views;
@property (nonatomic, retain, nonnull) NSMutableArray *attachedObjects;

@property (nonatomic, weak, nullable) PAYFormField *firstFormField;
@property (nonatomic, copy, nullable) PAYFormSectionCompletionBlock completionBlock;

- (BOOL)initFieldJumpOrderWithNextSection:(nonnull PAYFormSection *)section;
- (nullable PAYFormField *)firstFormField;

- (nullable NSError *)validate;

@end
