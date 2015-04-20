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

/**
 *  The view, where all sub-components are added. This view has to be manipulated 
 *  to change the appearance of one row of the form.
 */
@property (nonatomic, retain) UIView *view;

/**
 *  The cell view.
 */
@property (nonatomic, retain) UITableViewCell *cell;

@end
