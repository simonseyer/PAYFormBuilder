//
//  PAYFormRow.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  High level protocol to describe one form row.
 */
@protocol PAYFormRow <NSObject>

/**
 *  Get the view of the form row. Each row is rendered
 *  as a UITableViewCell, so you get this cell to manipulate it.
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)view;

/**
 *  Handles the selection of a row. Do NOT call this method by
 *  yourself.
 */
- (void)didSelectRow;

@end

