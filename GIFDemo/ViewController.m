//
//  ViewController.m
//  GIFDemo
//
//  Created by srx on 2016/12/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "ViewController.h"

#import "YLImageView+WebCache.h"
#import "YLImageView.h"
#import "YLGIFImage.h"

#define gif_1_url @"http://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2016-11/2016112319315482899.gif"
#define gif_2_url @"http://s1.dwstatic.com/group1/M00/F6/7D/280b1d47f0df1cd90c37385288758ef2.gif"
#define gif_3_url @""

#define gif_1 @"gif1"
#define gif_2 @"gif2"
#define gif_3 @"gif3"

#define Image_url @"http://a.hiphotos.baidu.com/image/pic/item/8435e5dde71190efeefb4933ca1b9d16fcfa60de.jpg"

@interface ViewController ()
{
    YLImageView * _imgViewPath;
    YLImageView * _imgViewURL;
    UIButton    * _btn;
    UIButton    * _playPauseButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    _imgViewPath = [[YLImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imgViewPath.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_imgViewPath];
    
    _imgViewURL = [[YLImageView alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
    _imgViewPath.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_imgViewURL];
    
    NSArray * pathArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"."];
    NSData * data = [NSData dataWithContentsOfFile:pathArray[arc4random() % pathArray.count]];
    UIImage* gifImg = [YLGIFImage imageWithData:data];
    _imgViewPath.image = gifImg;
    [_imgViewURL sd_setImageWithURL:[NSURL URLWithString:gif_1_url]];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(10, 340, 70, 70);
    _btn.backgroundColor = [UIColor orangeColor];
    _btn.selected = NO;
    [_btn setTitle:@"换图片" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playPauseButton.frame = CGRectMake(90, 340, 70, 70);
    _playPauseButton.backgroundColor = [UIColor orangeColor];
    _playPauseButton.selected = NO;
    [_playPauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    [_playPauseButton setTitle:@"播放" forState:UIControlStateSelected];
    [_playPauseButton addTarget:self action:@selector(playPauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playPauseButton];
    
    
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 420, CGRectGetWidth(self.view.frame), 80)];
    infoLabel.numberOfLines = 0;
    infoLabel.adjustsFontSizeToFitWidth = YES;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = @"gif 基于SDWebImage\n 动图随便玩\n\n点击空白区域 随机切换图片";
    [self.view addSubview:infoLabel];
}

- (void)btnClick {
    _imgViewPath.image = [[UIImage alloc] init];
    _imgViewURL.image = [[UIImage alloc] init];
    
    _btn.selected = !_btn.selected;
    if(_btn.selected) {
        [_imgViewPath sd_setImageWithURL:[NSURL URLWithString:gif_2_url]];
        [_imgViewURL sd_setImageWithURL:[NSURL URLWithString:Image_url]];
    }
    else {
        [_imgViewPath sd_setImageWithURL:[NSURL URLWithString:Image_url]];
        [_imgViewURL sd_setImageWithURL:[NSURL URLWithString:gif_1_url]];
    }
}

- (void)playPauseButtonClick {
    _playPauseButton.selected = !_playPauseButton.isSelected;
    if(_playPauseButton.isSelected) {
        [_imgViewPath stopAnimating];
        [_imgViewURL stopAnimating];
    }
    else {
        [_imgViewPath startAnimating];
        [_imgViewURL startAnimating];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //这个是 搜索所有 导入并选择为该工程中 以 .gif为扩展名的文件
    NSArray * pathArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"."];
    NSData * data = [NSData dataWithContentsOfFile:pathArray[arc4random() % pathArray.count]];
    UIImage* gifImg = [YLGIFImage imageWithData:data];
    _imgViewPath.image = gifImg;
    [_imgViewURL sd_setImageWithURL:[NSURL URLWithString:gif_1_url]];
    
    _playPauseButton.selected = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
