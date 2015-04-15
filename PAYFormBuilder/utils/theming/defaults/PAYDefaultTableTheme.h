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

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat labelStyleNoneHeight;
@property (nonatomic, assign) CGFloat labelStyleEmptyHeight;
@property (nonatomic, assign) CGFloat infoIconMargin;

@end
