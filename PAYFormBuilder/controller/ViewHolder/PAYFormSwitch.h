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
@property (nonatomic, retain) UILabel *label;

/**
 *  The switch control
 */
@property (nonatomic, retain) UISwitch *switchControl;

/**
 *  Validates, that the control is selected
 */
@property (nonatomic, assign) BOOL isRequired;

/**
 *  True, when the switch is turned on, false otherwise
 */
@property (nonatomic, assign) BOOL value;

@end
