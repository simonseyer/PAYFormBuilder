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

@property (nonatomic, retain) NSLayoutConstraint *iconWidthConstraint;
@property (nonatomic, retain) NSLayoutConstraint *iconHeightConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewIconLeftConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewIconCenterVerticalConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewIconCenterVerticalHelperConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewIconLabelConstraint;

@property (nonatomic, retain) NSLayoutConstraint *viewLabelDetailLabelConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelTopConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelRightConstraint;
@property (nonatomic, retain) NSLayoutConstraint *viewDetailLabelBottomConstraint;
@property (nonatomic, retain) NSLayoutConstraint *detailLabelHeightConstraint;


@end
