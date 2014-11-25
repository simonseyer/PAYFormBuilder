//
//  PAYValidatableFormCell.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^PAYFormFieldResetBlock)();


@protocol PAYValidatableFormCell <NSObject>

- (NSError *)validate;
- (void)resetValidation;
- (NSString *)name;

@property (nonatomic, copy) PAYFormFieldResetBlock validationResetBlock;

@end
