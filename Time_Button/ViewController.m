//
//  ViewController.m
//  Time_Button
//
//  Created by iOS on 2018/8/14.
//  Copyright © 2018年 Leely. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+CountDown.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 30);
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(sendMsgCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)sendMsgCode:(UIButton *)btn {
    __block UIButton *button = btn;
    [button ba_countDownWithTimeInterval:60 countDownFormat:@"已发送(%zd)"];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
