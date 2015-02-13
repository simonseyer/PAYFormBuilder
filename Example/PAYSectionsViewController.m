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

- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {
    [tableBuilder addSectionWithContentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style empty"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone
                              contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style none"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithName:@"Label style simple (default)"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style simple"
                                    style:PAYFormButtonStyleDisabledCentered
                           selectionBlock:nil];
                          }];
    
    [tableBuilder addSectionWithName:@"Section with info button"
                        contentBlock:^(PAYFormSectionBuilder *sectionBuilder) {
                            [sectionBuilder addButtonWithText:@"Simple Entry"
                                                        style:PAYFormButtonStyleDisabledCentered
                                               selectionBlock:nil];
                        }
                           infoBlock:^(UIButton *infoButton) {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                                                   message:@"This alert could explain what the section is about."
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"Dismiss"
                                                                         otherButtonTitles:@"More help", nil];
                               [alertView show];
                           }];
    
    [tableBuilder addSectionWithName:@"Section with label style description and without any content."
                          labelStyle:PAYFormTableLabelStyleDescription
                        contentBlock:nil];
    
    [tableBuilder addSectionWithName:@"Section with label style description wide and without any content."
                          labelStyle:PAYFormTableLabelStyleDescriptionWide
                        contentBlock:nil];
    [tableBuilder addSectionWithHeaderBlock:^(PAYFormHeader *formHeader) {
        UILabel *customLabel = [UILabel new];
        customLabel.textColor = [UIColor colorFromHex:0xFF5e3a];
        customLabel.text = @"Custom header";
        
        [customLabel sizeToFit];
        customLabel.frame = CGRectOffset(customLabel.frame, 20, 20);
        formHeader.view.frame = CGRectInset(customLabel.frame, 0, -15);
        
        [formHeader.view addSubview:customLabel];
    } contentBlock:^(PAYFormSectionBuilder *sectionBuilder) {
        [sectionBuilder addFieldWithPlaceholder:@"Another Entry"];
    }];
    
    PAYHeaderView *header = [[PAYHeaderView alloc]initWithFrame:self.view.frame];
    header.iconImage = [UIImage imageNamed:@"header"];
    header.title = @"Test";
    header.subTitle = @"Dies ist ein Test";
    self.tableView.tableHeaderView = header;
}

@end
