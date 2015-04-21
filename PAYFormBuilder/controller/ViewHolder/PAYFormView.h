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

@property (nonatomic, retain) NSLayoutConstraint *viewLabelTopConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewLabelRightConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewLabelBottomConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewLabelLeftConstraint;
@property (nonatomic, retain) NSLayoutConstraint *labelWidthConstraint;
@property (nonatomic, retain) NSLayoutConstraint *labelHeightConstraint;

@property (nonatomic, retain) NSLayoutConstraint *viewLabelControlConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewControlTopConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewControlRightConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewControlBottomConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewControlLeftConstraint;
@property (nonatomic, retain) NSLayoutConstraint *controlHeightContraint;

@end
