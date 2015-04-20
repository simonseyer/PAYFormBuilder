//
//  PAYFormHeader.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormHeader.h"
#import "PAYFormHeader_protected.h"


@implementation PAYFormHeader

- (void)setHeader:(UITableViewHeaderFooterView *)header {
    _header = header;
    _view = header.contentView;
}

@end
