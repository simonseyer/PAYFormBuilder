//
//  PAYFormErrorMessage_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormErrorMessage.h"

@protocol PAYValidatableFormCell;

@interface PAYFormErrorMessage ()

- (nonnull NSString *)titleForField:(nonnull id<PAYValidatableFormCell>)field;
- (nonnull NSString *)messageForField:(nonnull id<PAYValidatableFormCell>)field;

@end
