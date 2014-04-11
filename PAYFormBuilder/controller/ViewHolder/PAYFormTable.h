//
//  PAYFormTable.h
//  paij
//
//  Created by Marius Rackwitz on 18.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"
#import "PAYFormSection.h"


@interface PAYFormTable : NSObject

@property (nonatomic, retain) NSMutableArray *sections;

@property (nonatomic, assign) BOOL selectFirstField;
@property (nonatomic, assign) BOOL finishOnLastField;

@property (nonatomic, copy) PAYFormValidationBlock validationBlock;
@property (nonatomic, copy) PAYFormTableCompletionBlock completionBlock;
@property (nonatomic, copy) PAYFormTableSuccessBlock formSuccessBlock;
@property (nonatomic, copy) PAYFormTableFailBlock formFailBlock;

- (void)initSectionJumpOrder;
- (void)validate;

@end
