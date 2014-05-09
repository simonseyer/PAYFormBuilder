//
//  PAYHeaderView.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAYTextLabel.h"

@interface PAYHeaderView : UIView

@property (nonatomic, retain) UIImage  *iconImage;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subTitle;

@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) PAYTextLabel *titleLabel;
@property (nonatomic, retain) PAYTextLabel *subTitleLabel;


@property (nonatomic, assign) NSUInteger iconTopMargin      UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger titleTopMargin     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger subTitleTopMargin  UI_APPEARANCE_SELECTOR;

@end
