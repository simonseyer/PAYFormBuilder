//
//  PAYFormHeader.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

/**
 *  Holds the content of a section header
 */
@interface PAYFormHeader : NSObject

/**
 *  The header view
 */
@property (nonatomic, retain, readonly, nonnull) UITableViewHeaderFooterView *header;

/**
 *  The view, that is visible in the header
 */
@property (nonatomic, retain, readonly, nonnull) UIView *view;

/**
 *  The label, that contains the name of the section
 */
@property (nonatomic, retain, readonly, nonnull) UILabel *label;

/**
 *  An optional button, which provides additional help
 */
@property (nonatomic, retain, readonly, nullable) UIButton *infoButton;

/**
 *  The block that is called when the info button is pressed
 */
@property (nonatomic, copy, nullable) void (^infoBlock)(UIButton * _Nonnull);

/**
 * Constrains the height of the header view. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewHeightConstraint;

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
 * Constrains the trailing spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewInfoIconRightConstraint;

/**
 * Constrains the bottom spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewInfoIconBottomConstraint;

@end
