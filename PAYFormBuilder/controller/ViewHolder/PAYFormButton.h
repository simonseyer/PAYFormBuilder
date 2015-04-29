//
//  PAYFormButton.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"

typedef void(^PAYFormButtonSelectionBlock)(PAYFormButton *);
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
@property (nonatomic, retain, readonly) UILabel *label;

/**
 *  The detail label
 */
@property (nonatomic, retain, readonly) UILabel *detailLabel;

/**
 *  The icon
 */
@property (nonatomic, retain, readonly) UIImageView *iconView;

/**
 *  A block that is called when the user tapped on the button
 */
@property (nonatomic, copy) PAYFormButtonSelectionBlock selectionBlock;

/**
 *  True, if the button is in selected state, false otherwise
 */
@property (nonatomic, assign) BOOL selected;

/**
 * Constrains the icon width. Added to the iconView.
 */
@property (nonatomic, retain) NSLayoutConstraint *iconWidthConstraint;

/**
 * Constrains the icon height. Added to the iconView.
 */
@property (nonatomic, retain) NSLayoutConstraint *iconHeightConstraint;

/**
 * Constrains the leading spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewIconLeftConstraint;

/**
 * Constrains the vertical position of the icon. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewIconCenterVerticalConstraint;

/**
 * Helps to constrain the vertical position of the icon. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewIconCenterVerticalHelperConstraint;

/**
 * Constrains the spacing between the icon and the label. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewIconLabelConstraint;

/**
 * Constrains the spacing between the label and the detailLabel. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewLabelDetailLabelConstraint;

/**
 * Constrains the top spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelTopConstraint;

/**
 * Constrains the trailing spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelRightConstraint;

/**
 * Constrains the bottom spacing between the icon and the superview. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelBottomConstraint;

/**
 * Constrains the height of the detailLabel. Added to the detailLabel.
 */
@property (nonatomic, retain) NSLayoutConstraint *detailLabelHeightConstraint;


@end
