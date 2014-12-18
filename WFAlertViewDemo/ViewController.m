//
//  ViewController.m
//  WFAlertViewDemo
//
//  Created by jwfstars on 14/12/17.
//  Copyright (c) 2014年 Wenfan Jiang. All rights reserved.
//

#import "ViewController.h"
#import "WFAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlertView:(id)sender {
    
    WFAlertView *alertView = [[WFAlertView alloc]initWithTitle:@"Title" message:@"This is a message! This is a message! This is a message!" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] cancelButtonBlock:^{
        NSLog(@"Cancel");
    } otherButtonBlock:^(NSInteger buttonIndex) {
        NSLog(@"OK - %ld", (long)buttonIndex);
    }];
    
    alertView.buttonType = WFAlertViewButtonTypeHorizontal;
    alertView.showTitleBG = YES;
    [alertView show];
}


@end
