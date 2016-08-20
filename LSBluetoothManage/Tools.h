//
//  Tools.h
//  517job
//
//  Created by noci on 16/4/22.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject
//字符串是否纯数字
+ (BOOL)isPureFloat:(NSString*)string;
//字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;


+(UIViewController *)getCurrentViewController;
+(UIViewController *)getCurrentPresentViewController:(UIViewController *)vc;


//判断是否是手机号
+(BOOL)isMobileNumber:(NSString *)mobileNum;

//判断是否是邮箱
+ (BOOL) validateEmail:(NSString *)email;


@end
