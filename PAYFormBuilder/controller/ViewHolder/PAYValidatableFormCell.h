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

/**
 *  An array of `PAYFormFieldResetBlock`s to reset the style
 *  of the form cell back to default.
 */
@property (nonatomic, retain) NSMutableArray *validationResetBlocks;

@end
