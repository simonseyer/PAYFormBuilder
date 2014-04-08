//
//  PAYFormButton.h
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormView.h"


@interface PAYFormButton : PAYFormView

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, assign) PAYFormButtonStyle style;
@property (nonatomic, copy) PAYFormSelectionBlock selectionBlock;
@property (nonatomic, assign) BOOL selected;

- (void)setEnabled:(BOOL)enabled;
- (void)requestSelection;

@end
