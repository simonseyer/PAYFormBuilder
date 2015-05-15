//
//  PAYFormTableBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTableBuilder.h"
#import "PAYFormTableBuilder_protected.h"
#import "PAYFormSection.h"
#import "PAYFormSectionBuilder.h"
#import "PAYFormSectionBuilder_protected.h"
#import "PAYFormHeader.h"
#import "PAYFormHeader_protected.h"
#import "PAYTextLabel.h"
#import "BlocksKit+UIKit.h"
#import "PAYStyle.h"

@implementation PAYFormTableBuilder

@dynamic selectFirstField;
@dynamic finishOnLastField;
@dynamic validationBlock;
@dynamic formSuccessBlock;
@dynamic formFailBlock;


- (id)init {
    self = [super init];
    if (self) {
        self.table = [PAYFormTable new];
    }
    return self;
}

- (id)initWithFormTable:(PAYFormTable *)table {
    self = [super init];
    if (self) {
        self.table = table;
    }
    return self;
}

- (void)addSectionWithContentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithLabelStyle:PAYFormTableLabelStyleEmpty
                      contentBlock:contentBlock];
}

- (void)addSectionWithLabelStyle:(PAYFormTableLabelStyle)style
                    contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithName:nil
                  labelStyle:style
                 headerBlock:nil
                contentBlock:contentBlock];
}

- (void)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock
                     contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithName:nil
                  labelStyle:PAYFormTableLabelStyleEmpty
                 headerBlock:headerBlock
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithName:name
                  labelStyle:PAYFormTableLabelStyleSimple
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock
                 infoBlock:(void(^)(UIButton *))infoBlock {
    [self addSectionWithName:name
                  labelStyle:PAYFormTableLabelStyleSimple
                contentBlock:contentBlock
                   infoBlock:infoBlock];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithName:name
                  labelStyle:style
                 headerBlock:nil
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock
                 infoBlock:(void(^)(UIButton *))infoBlock {
    [self addSectionWithName:name
                  labelStyle:style
                 headerBlock:nil
                contentBlock:contentBlock
                   infoBlock:infoBlock];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
               headerBlock:(void(^)(PAYFormHeader *))headerBlock
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock {
    [self addSectionWithName:name
                  labelStyle:style
                 headerBlock:headerBlock
                contentBlock:contentBlock
                   infoBlock:nil];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
               headerBlock:(void(^)(PAYFormHeader *))headerBlock
              contentBlock:(void(^)(PAYFormSectionBuilder *))contentBlock
                 infoBlock:(void (^)(UIButton *))infoBlock {
    PAYFormSection *formSection = [PAYFormSection new];
    formSection.name = name;
    formSection.header = [PAYFormTableBuilder headerViewWithStyle:style name:name infoBlock:infoBlock];
    if (headerBlock) {
        headerBlock(formSection.header);
    }
    
    if (contentBlock) {
        PAYFormSectionBuilder *builder = [[PAYFormSectionBuilder alloc] initWithFormSection:formSection];
        contentBlock(builder);
    }
    
    [self.table.sections addObject:formSection];
}

+ (PAYFormHeader *)headerViewWithStyle:(PAYFormTableLabelStyle)style
                                  name:(NSString *)name
                             infoBlock:(void (^)(UIButton *))infoBlock {
    PAYFormHeader *formHeader = [PAYFormHeader new];
    formHeader.header           = [UITableViewHeaderFooterView new];
    formHeader.view.backgroundColor = UIColor.clearColor;
    
    if (style == PAYFormTableLabelStyleNone || style == PAYFormTableLabelStyleEmpty) {
        CGFloat headerHeight;
        if (style == PAYFormTableLabelStyleNone) {
            headerHeight = PAYStyle.tableTheme.labelStyleNoneHeight;
        } else {
            headerHeight = PAYStyle.tableTheme.labelStyleEmptyHeight;
        }
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[header(height@100)]"
                                                                       options:0
                                                                       metrics:@{@"height" : @(headerHeight)}
                                                                         views:@{@"header" : formHeader.view}];
        formHeader.viewHeightConstraint = constraints[0];
        [formHeader.view addConstraint:formHeader.viewHeightConstraint];
    } else {
        formHeader.label = [[PAYTextLabel alloc] initWithStyle:style];
        formHeader.label.text  = name;
        formHeader.label.translatesAutoresizingMaskIntoConstraints = NO;
        
        [formHeader.view addSubview:formHeader.label];
        
        NSDictionary *views = @{@"header" : formHeader.view, @"label" : formHeader.label};
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[label]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
            formHeader.viewLabelLeftConstraint = constraints[0];
            formHeader.viewLabelRightConstraint = constraints[1];
            
            [formHeader.view addConstraint:formHeader.viewLabelLeftConstraint];
            [formHeader.view addConstraint:formHeader.viewLabelRightConstraint];
        }
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
            formHeader.viewLabelTopConstraint = constraints[0];
            formHeader.viewLabelBottomConstraint = constraints[1];
            
            [formHeader.view addConstraint:formHeader.viewLabelTopConstraint];
            [formHeader.view addConstraint:formHeader.viewLabelBottomConstraint];
        }
    }
    
    if (infoBlock) {
        formHeader.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        formHeader.infoButton.translatesAutoresizingMaskIntoConstraints = NO;
        [formHeader.infoButton bk_addEventHandler:infoBlock forControlEvents:UIControlEventTouchUpInside];
        [formHeader.view addSubview:formHeader.infoButton];
        
        NSDictionary *views = @{@"info" : formHeader.infoButton, @"view" : formHeader.view};
        NSDictionary *metrics = @{@"iconMargin" : @(PAYStyle.tableTheme.infoIconMargin)};
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[info]-iconMargin-|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views];
            formHeader.viewInfoIconRightConstraint = constraints[0];
            [formHeader.view addConstraint:formHeader.viewInfoIconRightConstraint];
        }
        {
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[info]-iconMargin-|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views];
            formHeader.viewInfoIconBottomConstraint = constraints[0];
            [formHeader.view addConstraint:formHeader.viewInfoIconBottomConstraint];
        }
    }
    
    return formHeader;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.table respondsToSelector:aSelector]) {
        return self.table;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.table respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

@end
