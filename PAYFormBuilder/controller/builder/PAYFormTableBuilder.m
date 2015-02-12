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
        
        self.labelStyleNoneDefaultHeight = 32.0f;
        self.labelStylEmptyDefaultHeight = 36.0f;
        self.infoIconMargin              = 6.0f;
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
                 headerBlock:nil
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
    formSection.header = [self headerViewWithStyle:style name:name infoBlock:infoBlock];
    if (headerBlock) {
        headerBlock(formSection.header);
    }
    
    if (contentBlock) {
        PAYFormSectionBuilder *builder = [[PAYFormSectionBuilder alloc] initWithFormSection:formSection
                                                                          defaultCellBounds:self.defaultBounds];
        contentBlock(builder);
    }
    
    [self.table.sections addObject:formSection];
}

- (PAYFormHeader *)headerViewWithStyle:(PAYFormTableLabelStyle)style
                                  name:(NSString *)name
                             infoBlock:(void (^)(UIButton *))infoBlock {
    UIView *headerView         = [[UIView alloc] initWithFrame:self.defaultBounds];
    headerView.backgroundColor = UIColor.clearColor;
    
    PAYTextLabel *textLabel = nil;
    CGRect headerRect = headerView.frame;
    if (style == PAYFormTableLabelStyleNone) {
        headerRect.size.height = self.labelStyleNoneDefaultHeight;
    } else if (style == PAYFormTableLabelStyleEmpty) {
        headerRect.size.height = self.labelStylEmptyDefaultHeight;
    } else {
        textLabel       = [[PAYTextLabel alloc] initWithFrame:self.defaultBounds];
        textLabel.style = style;
        textLabel.text  = name;
        [headerView addSubview:textLabel];
        
        headerRect.size.height = CGRectGetMaxY(textLabel.frame);
    }
    headerView.frame = headerRect;
    
    if (infoBlock) {
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        infoButton.frame = CGRectMake(headerView.frame.size.width - infoButton.frame.size.width - self.infoIconMargin,
                                      headerView.frame.size.height - infoButton.frame.size.height - self.infoIconMargin,
                                      infoButton.frame.size.width, infoButton.frame.size.height);
        [infoButton bk_addEventHandler:infoBlock forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:infoButton];
    }
    
    PAYFormHeader *formHeader    = [PAYFormHeader new];
    formHeader.view             = headerView;
    formHeader.label            = textLabel;
    
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
