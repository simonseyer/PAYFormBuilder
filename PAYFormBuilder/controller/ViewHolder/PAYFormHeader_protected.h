//
//  PAYFormHeader_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormHeader.h"

@interface PAYFormHeader ()

/**
 *  The header view
 */
@property (nonatomic, retain, nonnull) UITableViewHeaderFooterView *header;

/**
 *  The view, that is visible in the header
 */
@property (nonatomic, retain, nonnull) UIView *view;

/**
 *  The label, that contains the name of the section
 */
@property (nonatomic, retain, nonnull) UILabel *label;

/**
 *  An optional button, which provides additional help
 */
@property (nonatomic, retain, nullable) UIButton *infoButton;

/**
 *  Handles button presses of the info button
 *
 *  @param button the info button
 */
- (void)handleInfoButtonPress:(nonnull UIButton *)button;

@end
