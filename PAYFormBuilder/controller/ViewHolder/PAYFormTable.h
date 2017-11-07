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


typedef NSError * _Nullable (^PAYFormValidationBlock)(void);
typedef void(^PAYFormTableCompletionBlock)(void);
typedef void (^PAYFormTableSuccessBlock)(void);
typedef BOOL (^PAYFormTableFailBlock)(NSError * _Nonnull error);


@interface PAYFormTable : NSObject

@property (nonatomic, retain, nonnull) NSMutableArray *sections;

@property (nonatomic, assign) BOOL selectFirstField;
@property (nonatomic, assign) BOOL finishOnLastField;

@property (nonatomic, copy, nullable) PAYFormValidationBlock validationBlock;
@property (nonatomic, copy, nullable) PAYFormTableCompletionBlock completionBlock;
@property (nonatomic, copy, nullable) PAYFormTableSuccessBlock formSuccessBlock;
@property (nonatomic, copy, nullable) PAYFormTableFailBlock formFailBlock;

- (void)initSectionJumpOrder;
- (void)validate;

@end
