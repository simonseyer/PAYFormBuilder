//
//  PAYFormToggle.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYValidatableFormCell.h"

/**
 *  A form view with a switch control
 */
@interface PAYFormSwitch : PAYFormView <PAYValidatableFormCell>

/**
 *  The label, that is displayed in front of the switch
 */
@property (nonatomic, retain, readonly) UILabel *label;

/**
 *  The switch control
 */
@property (nonatomic, retain, readonly) UISwitch *switchControl;

/**
 *  Validates, that the control is selected
 */
@property (nonatomic, assign, getter=isRequired) BOOL required;

/**
 *  True, when the switch is turned on, false otherwise
 */
@property (nonatomic, assign) BOOL value;

/**
 * Constrains the vertical position of the switch. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewSwitchCenterVerticalConstraint;

/**
 * Helps to constrain the vertical position of the switch. Added to the view.
 */
@property (nonatomic, retain) NSLayoutConstraint *viewSwitchCenterVerticalHelperConstraint;

@end
