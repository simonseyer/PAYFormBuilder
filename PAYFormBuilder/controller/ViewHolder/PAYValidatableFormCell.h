//
//  PAYValidatableFormCell.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PAYValidatableFormCell <NSObject>

- (NSError *)validate;
- (void)styleForError:(NSError *)error;
- (NSString *)name;

@end
