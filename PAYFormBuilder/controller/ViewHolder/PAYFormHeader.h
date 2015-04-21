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

/**
 * Constrains the height of the header view. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewHeightConstraint;

/**
 * Constrains the top spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewLabelTopConstraint;

/**
 * Constrains the trailing spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewLabelRightConstraint;

/**
 * Constrains the bottom spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewLabelBottomConstraint;

/**
 * Constrains the leading spacing between the label and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewLabelLeftConstraint;

/**
 * Constrains the trailing spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewInfoIconRightConstraint;

/**
 * Constrains the bottom spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewInfoIconBottomConstraint;

@end
