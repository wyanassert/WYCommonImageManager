//
//  ViewController.m
//  CommonImageManager
//
//  Created by wyan assert on 2017/3/9.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "CommonImageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[CommonImageManager sharedInstance] configureBundlesName:@[@"MainResource", @"TargetResource"]];
    
    UIImageView *image0 = [[UIImageView alloc] init];
    image0.frame = CGRectMake(100, 100, 100, 100);
    image0.image = [UIImage imageNamed:@"QQ20170306-213441"];
    [self.view addSubview:image0];
    
    UIImageView *image1 = [[UIImageView alloc] init];
    image1.frame = CGRectMake(100, 300, 100, 100);
    image1.image = [UIImage imageNamed:@"image_loading_2"];
    [self.view addSubview:image1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
