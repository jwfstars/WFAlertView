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

- (IBAction)showAlertView:(id)sender {
    
//    //Init
//    WFAlertView *alertView1 = [[WFAlertView alloc]initWithTitle:@"Title" message:@"This is a message! This is a message! This is a message!" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] cancelButtonBlock:^{
//        NSLog(@"Cancel");
//    } otherButtonBlock:^(NSInteger buttonIndex) {
//        NSLog(@"OK - %ld", (long)buttonIndex);
//    }];
    
    
    WFAlertView *alertView= [[WFAlertView alloc]initWithTitle:@"title" message:@"gg" textFieldMessage:nil textFieldValue:nil cancelButtonTitle:@"cancel" otherButtonTitles:@[@"ok"] cancelButtonBlock:nil textFieldBlock:^(UITextField *textField) {
        NSLog(@"%@",textField.text);
    }];
    
    //Properties
    alertView.buttonType = WFAlertViewButtonTypeHorizontal;
    
    alertView.showTitleBG = YES;
    
    alertView.xButtonPositionInsets = UIEdgeInsetsMake(8, 0, 0, 8);
    
    alertView.marginInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    alertView.title2messageMargin = 50;
//    alertView.message2ButtonMargin = 50;
//    alertView.buttonHorizontalMargin = 1;
//    alertView.buttonVerticalMargin = 6;
    //Show
    [alertView show];
}


@end
