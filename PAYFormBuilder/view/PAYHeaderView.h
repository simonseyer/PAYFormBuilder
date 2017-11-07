//
//  PAYHeaderView.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAYTextLabel.h"

/**
 *  A view to display a table header with a fixed style.
 */
@interface PAYHeaderView : UIView

/**
 *  The icon image
 */
@property (nonatomic, retain, nullable) UIImage  *iconImage;

/**
 *  The title
 */
@property (nonatomic, retain, nullable) NSString *title;

/**
 *  The sub title
 */
@property (nonatomic, retain, nullable) NSString *subTitle;

/**
 *  The icon view
 */
@property (nonatomic, retain, nullable) UIImageView *iconView;

/**
 *  The title label
 */
@property (nonatomic, retain, nullable) PAYTextLabel *titleLabel;

/**
 *  The subtitle label
 */
@property (nonatomic, retain, nullable) PAYTextLabel *subTitleLabel;

@end
