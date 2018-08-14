//
//  UIButton+CountDown.h
//  Time_Button
//
//  Created by iOS on 2018/8/14.
//  Copyright © 2018年 Leely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

@property (nonatomic, copy) void(^timeStoppedCallback)(void);

/**
   设置倒计时的时间和文字显示
 
   @param duration   倒计时的时间
   @param format  可选参数， 默认“@%zd秒”
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration countDownFormat:(NSString *)format;



- (void)ba_cancelTimer;



@end
