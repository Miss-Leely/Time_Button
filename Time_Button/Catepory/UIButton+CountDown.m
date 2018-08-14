//
//  UIButton+CountDown.m
//  Time_Button
//
//  Created by iOS on 2018/8/14.
//  Copyright © 2018年 Leely. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign) NSTimeInterval endTime;

@property (nonatomic, copy) NSString *normalTitle;

@property (nonatomic, copy) NSString *formatTitle;

@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation UIButton (CountDown)

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setEndTime:(NSTimeInterval)endTime {
    objc_setAssociatedObject(self, @selector(endTime), @(endTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)endTime {
    
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}


-(void)setNormalTitle:(NSString *)normalTitle {
    objc_setAssociatedObject(self, @selector(normalTitle), normalTitle, OBJC_ASSOCIATION_COPY);
}


- (NSString *)normalTitle {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setFormatTitle:(NSString *)formatTitle {
    objc_setAssociatedObject(self, @selector(formatTitle), formatTitle, OBJC_ASSOCIATION_COPY);
}

- (NSString *)formatTitle {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setTimeStoppedCallback:(void (^)(void))timeStoppedCallback {
    objc_setAssociatedObject(self, @selector(timeStoppedCallback), timeStoppedCallback, OBJC_ASSOCIATION_COPY);
}


- (void(^)(void))timeStoppedCallback {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark ------ Public

- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration countDownFormat:(NSString *)format {
    
    if (!format) {
        self.formatTitle = @"%@zd秒";
    }else {
        self.formatTitle = format;
    }
    self.normalTitle = self.titleLabel.text;
    __block NSInteger timeOut = duration;
    __weak typeof (self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if (timeOut <= 0) {
            [weakSelf ba_cancelTimer];
        }else {
            NSString *title = [NSString stringWithFormat:weakSelf.formatTitle,timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:title forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    
    dispatch_resume(self.timer);
    
}

- (void)ba_cancelTimer {
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        //此处可根据自己的需求设置UI的显示
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        if (self.timeStoppedCallback) {
            self.timeStoppedCallback();
        }
    });
}


@end
