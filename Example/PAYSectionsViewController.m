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
                                    style:PAYFormButtonStyleDefault
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone
                              contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style none"
                                    style:PAYFormButtonStyleDefault
                           selectionBlock:nil];
    }];
    
    [tableBuilder addSectionWithName:@"Label style simple (default)"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Section with label style simple"
                                    style:PAYFormButtonStyleDefault
                           selectionBlock:nil];
                          }];
    
    [tableBuilder addSectionWithName:@"Section with info button"
                        contentBlock:^(PAYFormSectionBuilder *sectionBuilder) {
                            [sectionBuilder addButtonWithText:@"Simple Entry"
                                                        style:PAYFormButtonStyleDefault
                                               selectionBlock:nil];
                        }
                           infoBlock:^(UIButton *infoButton) {
                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Info"
                                                                                                        message:@"This alert could explain what the section is about."
                                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                               [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
                               [alertController addAction:[UIAlertAction actionWithTitle:@"More help" style:UIAlertActionStyleDefault handler:nil]];
                               [self presentViewController:alertController animated:YES completion:nil];
                           }];
    
    [tableBuilder addSectionWithName:@"Section with label style description and without any content."
                          labelStyle:PAYFormTableLabelStyleDescription
                        contentBlock:nil];
    
    [tableBuilder addSectionWithName:@"Section with label style description wide and without any content."
                          labelStyle:PAYFormTableLabelStyleDescriptionWide
                        contentBlock:nil];
    [tableBuilder addSectionWithHeaderBlock:^(PAYFormHeader *formHeader) {
        UILabel *customLabel = [UILabel new];
        customLabel.translatesAutoresizingMaskIntoConstraints = NO;
        customLabel.textColor = [UIColor colorFromHex:0xFF5e3a];
        customLabel.text = @"Custom header";
        [formHeader.view addSubview:customLabel];
        
        UIView *formView = formHeader.view;
        [formHeader.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[customLabel]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(customLabel, formView)]];
        [formHeader.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[customLabel]-10@500-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(customLabel, formView)]];
    } contentBlock:^(PAYFormSectionBuilder *sectionBuilder) {
        [sectionBuilder addFieldWithPlaceholder:@"Another Entry"];
    }];
    
    PAYHeaderView *header = [PAYHeaderView new];
    header.iconImage = [UIImage imageNamed:@"header"];
    header.title = @"The header title";
    header.subTitle = @"This is the subTitleLabel";
    self.tableView.tableHeaderView = header;
        
    PAYTextLabel *footerLabel = [[PAYTextLabel alloc] initWithStyle:PAYFormTableLabelStyleDescription];
    footerLabel.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.\n At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. \n\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum";

    UIView *footerView = [UIView new];
    [footerView addSubview:footerLabel];

    footerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [footerLabel.leadingAnchor constraintEqualToAnchor:footerView.leadingAnchor].active = YES;
    [footerLabel.trailingAnchor constraintEqualToAnchor:footerView.trailingAnchor].active = YES;
    [footerLabel.topAnchor constraintEqualToAnchor:footerView.topAnchor].active = YES;
    [footerLabel.bottomAnchor constraintEqualToAnchor:footerView.bottomAnchor].active = YES;

    self.tableView.tableFooterView = footerView;
}

@end
