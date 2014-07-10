//
//  PAYTableBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYSectionBuilder.h"
#import "PAYFormSection.h"
#import "PAYTextLabel.h"
#import "PAYFormTable.h"

@protocol PAYTableBuilder <NSObject>

/*
 Calls done when last text field is finished by the user. Has to be called inside the buildTable block.
 */
@optional
@property (nonatomic, assign) BOOL selectFirstField;
@property (nonatomic, assign) BOOL finishOnLastField;

@property (nonatomic, copy) PAYFormValidationBlock validationBlock;
@property (nonatomic, copy) PAYFormTableCompletionBlock completionBlock;
@property (nonatomic, copy) PAYFormTableSuccessBlock formSuccessBlock;
@property (nonatomic, copy) PAYFormTableFailBlock formFailBlock;

@required
- (PAYFormSection *)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithLabelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithName:(NSString *)name contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style headerBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;

@end
