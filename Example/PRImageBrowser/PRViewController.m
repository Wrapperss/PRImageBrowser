//
//  PRViewController.m
//  PRImageBrowser
//
//  Created by zhanglive@outlook.com on 08/17/2020.
//  Copyright (c) 2020 zhanglive@outlook.com. All rights reserved.
//

#import "PRViewController.h"
#import "PRImageBrowser.h"
#import "PRImageData.h"

@interface PRViewController ()

@end

@implementation PRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showImage:(id)sender {
    PRImageBrowser *browser = [[PRImageBrowser alloc] init];
    NSArray *imageDatas = @[
        [[PRImageData alloc] initNetworkImage:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1770492031,3636874066&fm=26&gp=0.jpg"],
        [[PRImageData alloc] initNetworkImage:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597911055707&di=aa8f97024d5fbc6a74b3c4d6ed7b63b0&imgtype=0&src=http%3A%2F%2Fpic3.58cdn.com.cn%2Fzhuanzh%2Fn_v275b1891d991b44e8b021c03419f07bc2.jpg%3Fw%3D750%26h%3D0"],
        [[PRImageData alloc] initNetworkImage:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=44396857,1277996565&fm=26&gp=0.jpg"],
    ];
    
    [browser showImages:imageDatas];
}

@end
