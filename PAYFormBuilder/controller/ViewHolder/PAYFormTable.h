//
//  PAYFormTable.h
//  PAYFormBuilder
//
//  Created by Marius Rackwitz on 18.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"
#import "PAYValidation.h"


typedef NSError *(^PAYFormValidationBlock)();
typedef void(^PAYFormTableCompletionBlock)();
typedef void (^PAYFormTableSuccessBlock)();
typedef BOOL (^PAYFormTableFailBlock)(NSError *error);


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
