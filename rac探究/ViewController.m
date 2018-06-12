//
//  ViewController.m
//  rac探究
//
//  Created by jinjun on 2018/6/8.
//  Copyright © 2018年 jinjun. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 创建信号 */
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        /* 发送信号 */
        [subscriber sendNext:@"发送信号"];
        
        return nil;
    }];
    
    /* 订阅信号 */
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"信号内容：%@", x);
    }];
    
    /* 取消订阅 */
    [disposable dispose];
    
    
    UIButton *btn;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];

    UITextField *textField;
    [[textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        
        return value.length > 5; // 表示输入文字长度 > 5 时才会调用下面的 block
        
    }] subscribeNext:^(NSString * _Nullable x) {
        
        NSLog(@"输入框内容：%@", x);
    }];
    
    
}


@end
