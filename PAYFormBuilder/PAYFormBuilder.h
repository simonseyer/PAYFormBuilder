//
//  PAYFormBuilder.h
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    PAYFormTableLabelStyleSimple,
    PAYFormTableLabelStyleDescription,
    PAYFormTableLabelStyleDescriptionWide,
    PAYFormTableLabelStyleEmpty,
    PAYFormTableLabelStyleNone
} PAYFormTableLabelStyle;

typedef enum {
    PAYFormButtonStyleCentered,
    PAYFormButtonStylePrimaryCentered,
    PAYFormButtonStyleHilightedCentered,
    PAYFormButtonStyleDisabledCentered,
    PAYFormButtonStyleDisclosure,
    PAYFormButtonStyleIconDisclosure,
    PAYFormButtonStyleSelection,
    PAYFormButtonStyleIconSelection,
    PAYFormButtonStyleEmpty
} PAYFormButtonStyle;


@class PAYFormTable;
@class PAYFormSection;
@class PAYFormField;
@class PAYFormSingleLineTextField;
@class PAYFormMultiLineTextField;
@class PAYFormButton;
@class PAYFormHeader;
@class PAYFormView;
@protocol PAYTableBuilder;
@protocol PAYSectionBuilder;
@protocol PAYFormCell;


typedef void(^PAYFormTableCompletionBlock)();
typedef void(^PAYFormSectionCompletionBlock)();
typedef void(^PAYFormFieldCompletionBlock)();
typedef void(^PAYFormSelectionBlock)(PAYFormView *);
typedef id(^PAYFormFieldFormatBlock)(PAYFormField *, id);
typedef id(^PAYFormFieldCleanBlock)(PAYFormField *, id);
typedef void(^PAYFormFieldErrorStylingBlock)(id, NSError *);
typedef void (^PAYFormTableSuccessBlock)();
typedef BOOL (^PAYFormTableFailBlock)(NSError *error);
typedef NSError *(^PAYFormFieldValidationBlock)(PAYFormField *);
typedef NSError *(^PAYFormValidationBlock)();

extern NSString * const PAYFormBuilderErrorControlKey;
extern NSString * const PAYFormBuilderErrorRecoveryOptionsKey;
extern NSString * const PAYFormBuilderErrorDomain;
extern NSInteger const PAYFormBuilderErrorCode;

@protocol PAYTableBuilder <NSObject>

/*
 Calls done when last text field is finished by the user. Has to be called inside the buildTable block.
 */
@property (nonatomic, assign) BOOL finishOnLastField;
@property (nonatomic, assign) BOOL selectFirstField;
@property (nonatomic, copy) PAYFormValidationBlock validationBlock;

- (PAYFormSection *)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock labelStyle:(PAYFormTableLabelStyle)style;
- (PAYFormSection *)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;
- (PAYFormSection *)addSectionWithName:(NSString *)name labelStyle:(PAYFormTableLabelStyle)style headerBlock:(void(^)(PAYFormHeader *))headerBlock contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock;

@end


@protocol PAYSectionBuilder <NSObject>

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder;
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormSelectionBlock)selectionBlock;
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock;

- (void)addView:(void(^)(PAYFormView *))configureBlock;

@end


@protocol PAYFormRow <NSObject>

- (UITableViewCell *)cell;
- (PAYFormSection *)section;

@optional
- (void)didSelectRow;

@end


@protocol PAYValidatableFormCell <NSObject>

@property (nonatomic, assign) PAYFormFieldErrorStylingBlock errorStylingBlock;

- (NSError *)validate;

@end
