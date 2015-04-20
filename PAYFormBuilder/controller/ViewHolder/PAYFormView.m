//
//  PAYFormView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYFormView_protected.h"
#import "UIColor+PAYHex.h"
#import "PAYNotifications.h"

NSString *const PAYFormViewLabelHorizontalConstraintKey = @"PAYFormViewLabelHorizontalConstraintKey";
NSString *const PAYFormViewLabelWidthConstraintKey = @"PAYFormViewLabelWidthConstraintKey";
NSString *const PAYFormViewLabelVerticalConstraintKey = @"PAYFormViewLabelVerticalConstraintKey";

NSString *const PAYFormViewControlHorizontalConstraintKey = @"PAYFormViewControlHorizontalConstraintKey";
NSString *const PAYFormViewControlVerticalConstraintKey = @"PAYFormViewControlVerticalConstraintKey";

@implementation PAYFormView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.constraints = @{}.mutableCopy;
    }
    return self;
}

- (void)setCell:(UITableViewCell *)cell {
    _cell = cell;
    _view = cell.contentView;
}

- (BOOL)becomeFirstResponder {
    [[NSNotificationCenter defaultCenter]postNotificationName:PAYFormRowFocusRequestNotification object:self.view];
    // Refuse first responder status, as no concrete replacement implementation was preferred.
    return NO;
}

- (void)didSelectRow {
    // Stub
}

- (void)addConstraintWithFormat:(NSString *)format key:(NSString *)key toViews:(NSDictionary *)views {
    [self addConstraintWithFormat:format options:0 key:key toViews:views];
}

- (void)addConstraintWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options key:(NSString *)key toViews:(NSDictionary *)views {
    NSArray *constrains = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                  options:options
                                                                  metrics:nil
                                                                    views:views];
    for (NSLayoutConstraint *constraint in constrains) {
        UIView *firstView = constraint.firstItem;
        UIView *secondView = constraint.secondItem;
        if ([firstView isDescendantOfView:secondView]) {
            [secondView addConstraint:constraint];
        } else if ([secondView isDescendantOfView:firstView]) {
            [firstView addConstraint:constraint];
        } else {
            [firstView.superview addConstraint:constraint];
        }
    }
    [self.constraints setValue:constrains forKey:key];
}


@end
