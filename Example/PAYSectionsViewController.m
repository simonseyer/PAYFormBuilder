//
//  PAYSectionsViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYSectionsViewController.h"

@interface PAYSectionsViewController ()

@end

@implementation PAYSectionsViewController

- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder {
    [tableBuilder addSectionWithContentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section without label style empty"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone
                              contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style none"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithName:@"Label style simple (default)"
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style simple"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
                          }];
    
    [tableBuilder addSectionWithName:@"Section with label style description and without any content."
                          labelStyle:PAYFormTableLabelStyleDescription
                        contentBlock:nil];
    
    [tableBuilder addSectionWithName:@"Section with label style description wide and without any content."
                          labelStyle:PAYFormTableLabelStyleDescriptionWide
                        contentBlock:nil];
    
}

@end
