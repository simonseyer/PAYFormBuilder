//
//  PAYFormButton.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"

FOUNDATION_EXPORT NSString *const PAYFormButtonDetailLabelHorizontalConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormButtonDetailLabelVerticalConstraintKey;

FOUNDATION_EXPORT NSString *const PAYFormButtonIconHorizontalConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormButtonIconVerticalConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormButtonIconWidthConstraintKey;
FOUNDATION_EXPORT NSString *const PAYFormButtonIconHeightConstraintKey;

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
@property (nonatomic, retain, readonly) UILabel *titleLabel;

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

@end
