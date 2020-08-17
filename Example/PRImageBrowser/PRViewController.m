//
//  PRViewController.m
//  PRImageBrowser
//
//  Created by zhanglive@outlook.com on 08/17/2020.
//  Copyright (c) 2020 zhanglive@outlook.com. All rights reserved.
//

#import "PRViewController.h"
#import "PRImageBrowser.h"

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
    [browser showImages:@[]];
}

@end
