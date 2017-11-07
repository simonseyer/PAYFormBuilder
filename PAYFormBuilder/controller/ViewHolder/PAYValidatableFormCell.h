//
//  PAYValidatableFormCell.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PAYValidatableFormCell <NSObject>

- (nullable NSError *)validate;
- (void)styleForError:(nullable NSError *)error;
- (nullable NSString *)name;

@end
