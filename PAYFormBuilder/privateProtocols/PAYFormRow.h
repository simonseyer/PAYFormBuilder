//
//  PAYFormRow.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PAYFormRow <NSObject>

- (UITableViewCell *)view;


@optional
- (void)didSelectRow;

@end

