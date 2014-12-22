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
    

//    [WFAlertView showAlertWithTitle:@"ggg" message:@"gagag" cancelButtonTitle:@"gg" otherButtonTitles:@[@"gg"] cancelButtonBlock:nil otherButtonBlock:nil];
    [WFAlertView showAlertWithTitle:@"title" message:nil textFieldMessage:@"text" textFieldValue:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil cancelButtonBlock:nil textFieldBlock:nil];
}


@end
