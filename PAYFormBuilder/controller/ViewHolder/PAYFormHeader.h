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
 *  The view, that is visible in the header
 */
@property (nonatomic, retain, readonly) UIView *view;

/**
 *  The label, that contains the name of the section
 */
@property (nonatomic, retain, readonly) UILabel *label;

@end
