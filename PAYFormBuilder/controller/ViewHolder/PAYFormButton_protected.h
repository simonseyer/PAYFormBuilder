//
//  PAYFormButton_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButton.h"

@interface PAYFormButton ()

/**
 *  The title label
 */
@property (nonatomic, retain) UILabel *titleLabel;

/**
 *  The icon
 */
@property (nonatomic, retain) UIImageView *iconView;

/**
 *  The style
 */
@property (nonatomic, assign) PAYFormButtonStyle style;

@end
