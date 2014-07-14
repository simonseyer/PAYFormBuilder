//
//  PAYFormButtonGroup.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYValidatableFormCell.h"

@class PAYFormSection;
@class PAYFormButton;

/**
 *  Manages a list of buttons and correspondig values
 */
@interface PAYFormButtonGroup : NSObject <PAYValidatableFormCell>

/**
 *  True, if multiple buttons could be selected at once
 */
@property (nonatomic, assign) BOOL multiSelection;

/**
 *  Validates that at least one button is selected
 */
@property (nonatomic, assign) BOOL isRequired;

/**
 *  The list of selected values
 */
@property (nonatomic, retain, readonly) NSArray *values;

/**
 *  One selected value. If multiSelection is enabled, any
 *  of the selected values is returned.
 */
@property (nonatomic, retain, readonly) id value;

/**
 *  Add a button that is associated with a value.
 *
 *  @param button the button to add
 *  @param value  the value that corresponds to the button
 */
- (void)addButton:(PAYFormButton *)button forValue:(id)value;

/**
 *  This method is called by the different buttons of the group,
 *  when they are tapped by the user
 *
 *  @param value the value of the button
 */
- (void)optionStateChanged:(id)value;

/**
 *  Selects or unselectes a value
 *
 *  @param select true, if the value/button should be selected, false otherwise
 *  @param value  the corresponding value
 */
- (void)select:(BOOL)select value:(id)value;

/**
 *  Select a value, if it is not already selected
 *
 *  @param value the value, that should be selected
 */
- (void)select:(id)value;

@end
