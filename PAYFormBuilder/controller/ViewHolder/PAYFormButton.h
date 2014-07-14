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
    PAYFormButtonStyleCentered,
    PAYFormButtonStylePrimaryCentered,
    PAYFormButtonStyleHilightedCentered,
    PAYFormButtonStyleDisabledCentered,
    PAYFormButtonStyleDisclosure,
    PAYFormButtonStyleIconDisclosure,
    PAYFormButtonStyleSelection,
    PAYFormButtonStyleIconSelection,
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
 *  The icon
 */
@property (nonatomic, retain, readonly) UIImageView *iconView;

/**
 *  The style
 */
@property (nonatomic, assign, readonly) PAYFormButtonStyle style;

/**
 *  A block that is called when the user tapped on the button
 */
@property (nonatomic, copy) PAYFormButtonSelectionBlock selectionBlock;

/**
 *  True, if the button is in selected state, false otherwise
 */
@property (nonatomic, assign) BOOL selected;

@end
