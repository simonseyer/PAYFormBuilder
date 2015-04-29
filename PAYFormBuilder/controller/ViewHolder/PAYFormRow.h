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
 *  Get the content view of the form row, where all view are added
 *
 *  @return the content view
 */
- (UIView *)view;

/**
 *  Get the UITableViewCell.
 *
 *  @return the cell view
 */
- (UITableViewCell *)cell;

/**
 *  Handles the selection of a row. Do NOT call this method by
 *  yourself.
 */
- (void)didSelectRow;

@end

