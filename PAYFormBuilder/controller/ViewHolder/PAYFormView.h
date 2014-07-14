//
//  PAYFormView.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"
#import "PAYFormRow.h"

/**
 *  High level model for one view in the form.
 */
@interface PAYFormView : NSObject<PAYFormRow>

@property (nonatomic, retain) UIColor *defaultErrorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *defaultTextColor UI_APPEARANCE_SELECTOR;

/**
 *  The view, where all sub-components are added. This view has to be manipulated 
 *  to change the appearance of one row of the form.
 */
@property (nonatomic, retain, readonly) UITableViewCell *view;

@end
