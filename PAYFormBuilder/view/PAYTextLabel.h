//
//  PAYFormLabel.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYTextLabel.h"


typedef enum {
    PAYFormTableLabelStyleSimple,
    PAYFormTableLabelStyleDescription,
    PAYFormTableLabelStyleDescriptionWide,
    PAYFormTableLabelStyleHeaderTitle,
    PAYFormTableLabelStyleHeaderSubTitle,
    PAYFormTableLabelStyleEmpty,
    PAYFormTableLabelStyleNone
} PAYFormTableLabelStyle;


/**
 *  A text label that changes it's appearence based on a style.
 */
@interface PAYTextLabel : UILabel

/**
 *  The style of the text label
 */
@property (nonatomic, assign) PAYFormTableLabelStyle style;

/**
 *  The preferred height based on the given width and the content.
 *
 *  @param width the maximum width
 *
 *  @return the preferred height
 */
- (CGFloat)preferredHeightForWidth:(CGFloat)width;

@end
