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

/**
 *  High level model for one view in the form.
 */
@interface PAYFormView : NSObject<PAYFormRow>

/**
 *  The view, where all sub-components are added. This view has to be manipulated 
 *  to change the appearance of one row of the form.
 */
@property (nonatomic, retain, nonnull) UIView *view;

/**
 *  The cell view.
 */
@property (nonatomic, retain, nonnull) UITableViewCell *cell;

/**
 * Constrains the top spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelTopConstraint;

/**
 * Constrains the trailing spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelRightConstraint;

/**
 * Constrains the bottom spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelBottomConstraint;

/**
 * Constrains the leading spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelLeftConstraint;

/**
 * Constrains the width of the label. Added to the label.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *labelWidthConstraint;

/**
 * Constrains the height of the label. Added to the label.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *labelHeightConstraint;

/**
 * Constrains the spacing between the label and the control. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelControlConstraint;

/**
 * Constrains the top spacing between the control and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewControlTopConstraint;

/**
 * Constrains the trailing spacing between the control and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewControlRightConstraint;

/**
 * Constrains the bottom spacing between the control and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewControlBottomConstraint;

/**
 * Constrains the leading spacing between the control and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewControlLeftConstraint;

/**
 * Constrains the height of the control. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *controlHeightContraint;

@end
