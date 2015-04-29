//
//  PAYDefaultTableTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import "PAYTableTheme.h"

@interface PAYDefaultTableTheme : NSObject <PAYTableTheme>

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIFont *subTitleFont;
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat labelStyleNoneHeight;
@property (nonatomic, assign) CGFloat labelStyleEmptyHeight;
@property (nonatomic, assign) CGFloat infoIconMargin;
@property (nonatomic, assign) CGFloat headerIconTopMargin;
@property (nonatomic, assign) CGFloat headerTitleTopMargin;
@property (nonatomic, assign) CGFloat headerSubTitleTopMargin;
@property (nonatomic, assign) UIColor *headerTintColor;

@end
