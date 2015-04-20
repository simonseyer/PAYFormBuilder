//
//  PAYFormHeader.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Holds the content of a section header
 */
@interface PAYFormHeader : NSObject

/**
 *  The header view
 */
@property (nonatomic, retain, readonly) UITableViewHeaderFooterView *header;

/**
 *  The view, that is visible in the header
 */
@property (nonatomic, retain, readonly) UIView *view;

/**
 *  The label, that contains the name of the section
 */
@property (nonatomic, retain, readonly) UILabel *label;

/**
 *  An optional button, which provides additional help
 */
@property (nonatomic, retain, readonly) UIButton *infoButton;

@end
