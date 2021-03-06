//
//  ViewController.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2017/12/4.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "peopleModel.h"
#import "endLessScro.h"
#import <AVFoundation/AVFoundation.h>
#import "CollectionViewController.h"
#import "EndLessViewController.h"
#import "BlueToothViewController.h"
#import "EndLessTableViewViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    textA *text = [[textA alloc] init];
//    [text NSlogText];
    
//    [self setSubView];
//    [self createRunloop];
//    [self setJson_Model];
//    [self setScr];
    [self pushToNextVC];
}

- (void)pushToNextVC {
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(0, 0, 100, 100);
    [clickBtn setBackgroundColor:[UIColor redColor]];
    [clickBtn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    clickBtn.center = self.view.center;
    [self.view addSubview:clickBtn];
}

- (void)nextVC {
    EndLessTableViewViewController *vc = [[EndLessTableViewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    BlueToothViewController *vc = [[BlueToothViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    EndLessViewController *vc = [[EndLessViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)playMp3 {
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickBtn setBackgroundColor:[UIColor redColor]];
    clickBtn.center = self.view.center;
    clickBtn.frame = CGRectMake(0, 0, 100, 100);
    [clickBtn addTarget:self action:@selector(playMp3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
    //音乐路径
    NSString *ringPath = [[NSBundle mainBundle] pathForResource:@"ding" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:ringPath];
    //创建播放器
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //预播放
    [_player prepareToPlay];
    //循环播放
    _player.numberOfLoops = 1;
    //音量大小
    _player.volume = 1.0;
    [_player play];
}

- (void)setScr {
    endLessScro *lessScr = [[endLessScro alloc] initWithDur:5 frame:CGRectMake(0, 0, 100, 100)];
    lessScr.center = self.view.center;
    [self.view addSubview:lessScr];
}

- (void)setJson_Model {
    NSDictionary *dic = @{@"name":@"aa", @"age":@"18", @"address":@"杭州", @"sex":@"男"};
    peopleModel *model = [[peopleModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    NSLog(@"model.name = %@, model.age = %@, model.address = %@， model.other = %@， model.myID = %@", model.name, model.age, model.address, model.other, model.myID);
    NSString *num = @"52445649151526675485126179718808368622015837477597399279545958780083787821736";
    long long rom = [num longLongValue] / 1000000;
    
}

- (void)createRunloop {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"--------%zd", activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);  // 添加监听者，关键！
    CFRelease(observer); // 释放
}

- (void)setSubView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
