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
    
    [WFAlertView showAlertWithTitle:@"title" message:@"message" textFieldMessage:nil textFieldValue:nil cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] cancelButtonBlock:^{
        
    } textFieldBlock:^(UITextField *textField) {
        
        
        NSLog(@"ok");
        
        [WFAlertView showAlertWithTitle:@"title" message:@"ggggg" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"jjgajg"] cancelButtonBlock:^{
            
        } otherButtonBlock:^(NSInteger buttonIndex) {
            
        }];
    }];
}


@end
