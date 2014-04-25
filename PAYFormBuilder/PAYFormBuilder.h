//
//  PAYFormBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
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
@class PAYFormButtonGroup;
@class PAYFormHeader;
@class PAYFormView;
@class PAYFormSwitch;
@protocol PAYTableBuilder;
@protocol PAYSectionBuilder;
@protocol PAYButtonGroupBuilder;
@protocol PAYFormCell;

typedef void(^PAYFormTableCompletionBlock)();
typedef void(^PAYFormSectionCompletionBlock)();
typedef void(^PAYFormFieldCompletionBlock)();
typedef void(^PAYFormButtonSelectionBlock)(PAYFormButton *);
typedef id(^PAYFormFieldFormatBlock)(PAYFormField *, id);
typedef id(^PAYFormFieldCleanBlock)(PAYFormField *, id);
typedef void (^PAYFormTableSuccessBlock)();
typedef BOOL (^PAYFormTableFailBlock)(NSError *error);
typedef NSError *(^PAYFormFieldValidationBlock)(PAYFormField *);
typedef NSError *(^PAYFormValidationBlock)();

extern NSString * const PAYFormErrorControlKey;
extern NSString * const PAYFormErrorRecoveryOptionsKey;
extern NSString * const PAYFormErrorDomain;
typedef enum {
    PAYFormDefaultErrorCode,
    PAYFormMissingErrorCode,
    PAYFormTextFieldAboveMaxLengthErrorCode,
    PAYFormTextFieldBelowMinLengthErrorCode
} PAYFormErrorCodes;

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


@protocol PAYSectionBuilder <NSObject>

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder;
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style icon:(UIImage *)icon selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock;

- (PAYFormButtonGroup *)addButtonGroupWithMutliSelection:(BOOL)multiSelection contentBlock:(void(^)(id<PAYButtonGroupBuilder>))contentBlock;

- (PAYFormSwitch *)addSwitchWithName:(NSString *)name;
- (PAYFormSwitch *)addSwitchWithName:(NSString *)name configureBlock:(void(^)(PAYFormSwitch *))configureBlock;

- (void)addView:(void(^)(PAYFormView *))configureBlock;

@end

@protocol PAYButtonGroupBuilder <NSObject>

@optional
- (void)select:(id)value;

@required
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text;
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text icon:(UIImage *)icon;
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text icon:(UIImage *)icon selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

@end


@protocol PAYFormRow <NSObject>

- (UITableViewCell *)cell;
- (PAYFormSection *)section;

@optional
- (void)didSelectRow;

@end


@protocol PAYValidatableFormCell <NSObject>


- (NSError *)validate;
- (void)styleForError:(NSError *)error;
- (NSString *)name;

@end
