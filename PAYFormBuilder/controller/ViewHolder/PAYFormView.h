//
//  PAYFormView.h
//  paij
//
//  Created by Simon Seyer on 05.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormBuilder.h"
#import "PAYFormSection.h"


@interface PAYFormView : NSObject<PAYFormRow>

@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, weak) PAYFormSection *section;

@end
