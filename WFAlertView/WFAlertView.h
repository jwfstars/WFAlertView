//
//  alertView.h
//  WFAlertView
//
//  Created by jwfstars on 14/12/11.
//  Copyright (c) 2014年 Wenfan Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^WFAlertViewCancelBlock)();
typedef void (^WFAlertViewOtherBlock)(NSInteger buttonIndex);
typedef void (^WFAlertViewTextFieldBlock)(UITextField *textField);

typedef NS_ENUM(NSInteger, WFAlertViewButtonType)
{
    WFAlertViewButtonTypeVertical,
    WFAlertViewButtonTypeHorizontal,
};

@interface WFAlertView : NSObject

//color
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *messageColor;
@property (strong, nonatomic) UIColor *cancelButtonColor;
@property (strong, nonatomic) UIColor *otherButtonColor;
@property (strong, nonatomic) UIColor *backgroundViewColor;
@property (strong, nonatomic) UIColor *textFieldTextColor;
@property (strong, nonatomic) UIColor *textFieldBorderColor;
@property (strong, nonatomic) UIColor *titleBGViewColor;

//Font
@property (strong, nonatomic) UIFont  *titleFont;
@property (strong, nonatomic) UIFont  *messageFont;
@property (strong, nonatomic) UIFont  *cancelButtonFont;
@property (strong, nonatomic) UIFont  *otherButtonFont;
@property (strong, nonatomic) UIFont  *textFieldTextFont;

//Animation
@property (assign, nonatomic) CGFloat  animationDuration;
@property (assign, nonatomic) CGFloat  animationSpringLevel;

//View
@property (assign, nonatomic) CGFloat  alertViewWidth;
@property (assign, nonatomic) CGFloat  viewCornerRadius;

//Button Type(排列方式)
@property (assign, nonatomic) CGFloat  buttonHeight;
@property (assign, nonatomic) WFAlertViewButtonType buttonType;
@property (assign, nonatomic) CGFloat  buttonCornerRadius;

//TextField
@property (assign, nonatomic) CGFloat  textFieldBorderWidth;
@property (assign, nonatomic) CGFloat  textFieldHeight;

//Alignment
@property (assign, nonatomic) NSTextAlignment messageTextAlignment;

//TitltBG
@property (assign, nonatomic) BOOL showTitleBG;

//"X"button
@property (assign, nonatomic) BOOL showXButton;
@property (assign, nonatomic) UIEdgeInsets xButtonPositionInsets; // right and top insets

//Margin
@property (assign, nonatomic) UIEdgeInsets marginInsets; //四边间距
@property (assign, nonatomic) CGFloat title2messageMargin;
@property (assign, nonatomic) CGFloat message2ButtonMargin;
@property (assign, nonatomic) CGFloat buttonVerticalMargin;
@property (assign, nonatomic) CGFloat buttonHorizontalMargin;

//image
@property (strong, nonatomic) UIImage *cancelButtonImage;
@property (strong, nonatomic) UIImage *otherButtonImage;

//control
@property (assign, nonatomic) BOOL canTouchCoverToDismiss;




+ (WFAlertView *)appearence;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:( NSArray *)otherButtonTitles
         cancelButtonBlock:(WFAlertViewCancelBlock)cancelButtonBlock
          otherButtonBlock:(WFAlertViewOtherBlock)otherButtonBlock;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
          textFieldMessage:(NSString *)textFieldMessage
            textFieldValue:(NSString *)textFieldValue
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:( NSArray *)otherButtonTitles
         cancelButtonBlock:(WFAlertViewCancelBlock)cancelButtonBlock
            textFieldBlock:(WFAlertViewTextFieldBlock)textFieldBlock;

@end

