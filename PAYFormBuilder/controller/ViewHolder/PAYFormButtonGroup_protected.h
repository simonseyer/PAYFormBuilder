//
//  PAYFormButtonGroup_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButtonGroup.h"

@interface PAYFormButtonGroup ()

/**
 *  True, if multiple buttons could be selected at once
 */
@property (nonatomic, assign) BOOL multiSelection;

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

@end
