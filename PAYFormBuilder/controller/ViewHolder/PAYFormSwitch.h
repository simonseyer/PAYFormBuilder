//
//  PAYFormToggle.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYValidatableFormCell.h"

@interface PAYFormSwitch : PAYFormView <PAYValidatableFormCell>

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UISwitch *switchControl;

@property (nonatomic, assign) BOOL isRequired;

@property (nonatomic, assign) BOOL value;

@end
