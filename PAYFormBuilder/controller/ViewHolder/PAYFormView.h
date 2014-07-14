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


@interface PAYFormView : NSObject<PAYFormRow>

@property (nonatomic, retain) UIColor *defaultErrorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *defaultTextColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, retain) UITableViewCell *view;

- (BOOL)becomeFirstResponder;

@end
