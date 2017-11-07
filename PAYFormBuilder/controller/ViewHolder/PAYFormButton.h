//
//  PAYFormButton.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"

typedef void(^PAYFormButtonSelectionBlock)(PAYFormButton * _Nonnull);
typedef enum {
    PAYFormButtonStyleDefault,
    PAYFormButtonStyleCentered,
    PAYFormButtonStyleHilighted,
    PAYFormButtonStylePrimary,
    PAYFormButtonStyleDisclosure,
    PAYFormButtonStyleSelection,
    PAYFormButtonStyleEmpty
} PAYFormButtonStyle;

/**
 *  A form view with a button
 */
@interface PAYFormButton : PAYFormView

/**
 *  The title label
 */
@property (nonatomic, retain, readonly, nonnull) UILabel *label;

/**
 *  The detail label
 */
@property (nonatomic, retain, readonly, nullable) UILabel *detailLabel;

/**
 *  The icon
 */
@property (nonatomic, retain, readonly, nullable) UIImageView *iconView;

/**
 *  A block that is called when the user tapped on the button
 */
@property (nonatomic, copy, nullable) PAYFormButtonSelectionBlock selectionBlock;

/**
 *  True, if the button is in selected state, false otherwise
 */
@property (nonatomic, assign) BOOL selected;

/**
 * Constrains the icon width. Added to the iconView.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *iconWidthConstraint;

/**
 * Constrains the icon height. Added to the iconView.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *iconHeightConstraint;

/**
 * Constrains the leading spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewIconLeftConstraint;

/**
 * Constrains the vertical position of the icon. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewIconCenterVerticalConstraint;

/**
 * Helps to constrain the vertical position of the icon. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewIconCenterVerticalHelperConstraint;

/**
 * Constrains the spacing between the icon and the label. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewIconLabelConstraint;

/**
 * Constrains the spacing between the label and the detailLabel. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewLabelDetailLabelConstraint;

/**
 * Constrains the top spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewDetailLabelTopConstraint;

/**
 * Constrains the trailing spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewDetailLabelRightConstraint;

/**
 * Constrains the bottom spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *viewDetailLabelBottomConstraint;

/**
 * Constrains the height of the detailLabel. Added to the detailLabel.
 */
@property (nonatomic, retain, nonnull) NSLayoutConstraint *detailLabelHeightConstraint;


@end
