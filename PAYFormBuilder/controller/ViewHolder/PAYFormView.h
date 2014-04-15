//
//  PAYFormView.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"
#import "PAYFormSection.h"


@interface PAYFormView : NSObject<PAYFormRow>

@property (nonatomic, assign) UIColor *defaultErrorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *defaultTextColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, weak) PAYFormSection *section;

@end
