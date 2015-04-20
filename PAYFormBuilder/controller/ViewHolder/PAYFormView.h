//
//  PAYFormView.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"
#import "PAYFormRow.h"


FOUNDATION_EXPORT NSString *const PAYFormViewLabelHorizontalConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormViewLabelWidthConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormViewLabelVerticalConstraintKey;

FOUNDATION_EXPORT NSString *const PAYFormViewControlHorizontalConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormViewControlVerticalConstraintKey;

/**
 *  High level model for one view in the form.
 */
@interface PAYFormView : NSObject<PAYFormRow>

/**
 *  The view, where all sub-components are added. This view has to be manipulated 
 *  to change the appearance of one row of the form.
 */
@property (nonatomic, retain) UIView *view;

/**
 *  The cell view.
 */
@property (nonatomic, retain) UITableViewCell *cell;

@property (nonatomic, retain) NSMutableDictionary *constraints;

- (void)addConstraintWithFormat:(NSString *)format key:(NSString *)key toViews:(NSDictionary *)views;
- (void)addConstraintWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options key:(NSString *)key toViews:(NSDictionary *)views;

@end
