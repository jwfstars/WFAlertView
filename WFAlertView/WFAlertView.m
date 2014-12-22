//
//  alertView.m
//  WFAlertView
//
//  Created by jwfstars on 14/12/11.
//  Copyright (c) 2014年 Wenfan Jiang. All rights reserved.
//

#import "WFAlertView.h"

#define kMargin 15
#define kTopMargin 10
#define kLeftRightMargin 20
#define kBottomMargin 20

#define kTextFieldLeftInset 10
#define kTextFieldBorderWidth 0.5



//Default UI
#define WFColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kBackgroundColor [UIColor whiteColor]//WFColorWithRGBA(255, 255, 255, 1)
#define kCancelButtonColor WFColorWithRGBA(119, 137, 144, 1)
#define kOtherButtonColor WFColorWithRGBA(206, 80, 81, 1)
#define kTitleColor         WFColorWithRGBA(87, 95, 97, 1)
#define kMessageColor       WFColorWithRGBA(168, 176, 178, 1)
#define kTitleBGViewColor WFColorWithRGBA(249, 249, 249, 1)
#define kTitleBGLineColor WFColorWithRGBA(212, 213, 215, 1)

#define kTitleFontSize 22
#define kMessageFontSize 16
#define kCancelButtonFontSize 16
#define kOtherButtonFontSize 16
#define kTitleFont                    [UIFont fontWithName:@"HelveticaNeue-Bold" size:kTitleFontSize]
#define kMessageFont                [UIFont fontWithName:@"Helvetica" size:kMessageFontSize]
#define kCancelButtonFont                    [UIFont fontWithName:@"Helvetica" size:kCancelButtonFontSize]
#define kOtherButtonFont                [UIFont fontWithName:@"Helvetica" size:kOtherButtonFontSize]

#define kAnimationSpringLevel 0.5f
#define kAnimationDuration 0.5f

#define kAlertViewWidth 300
#define kAlertViewHeight 200

#define kViewCornerRadius 1
#define kButtonCornerRadius 1
#define kButtonHeight 45


@interface UIView(WFAlertView)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat widthOfView;
@property (assign, nonatomic) CGFloat heightOfView;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@end

@interface WFAlertViewTextField : UITextField
@property (assign, nonatomic) UIEdgeInsets textContainerInset;
@end


typedef NS_ENUM(NSInteger, WFAlertViewType)
{
    WFAlertViewTypeNormal,
    WFAlertViewTypeTextField
};

@class WFAlertViewTextField;
@interface WFAlertView()<UITextFieldDelegate>

@property (copy, nonatomic) WFAlertViewCancelBlock cancelButtonBlock;
@property (copy, nonatomic) WFAlertViewOtherBlock otherButtonBlock;
@property (copy, nonatomic) WFAlertViewTextFieldBlock textFieldBlock;

@property (strong, nonatomic) UIView *cover;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *textFieldMessage;
@property (copy, nonatomic) NSString *textFieldValue;
@property (copy, nonatomic) NSString *cancelButtonTitle;
@property (copy, nonatomic) NSArray *otherButtonTitles;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *messageLabel;
@property (weak, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) UIButton *lastButton;
@property (strong, nonatomic) NSMutableArray *otherButtons;

@property (weak, nonatomic) UIWindow *window;
@property (weak, nonatomic) WFAlertViewTextField *textField;



@property (assign, nonatomic) WFAlertViewType type;



//margin
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat bottomMargin;

@end

@implementation WFAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelButtonBlock:(WFAlertViewCancelBlock)cancelButtonBlock otherButtonBlock:(WFAlertViewOtherBlock)otherButtonBlock
{
    if (self = [super initWithFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)] ) {
        
        NSAssert(title != nil || message != nil, @"Title or message must be non-nil");
        _title = title;
        _message = message;
        
        NSAssert(cancelButtonTitle != nil || otherButtonTitles.count, @"Alert view must have a button");
        _cancelButtonTitle = cancelButtonTitle;
        _otherButtonTitles = otherButtonTitles;
        _cancelButtonBlock = cancelButtonBlock;
        _otherButtonBlock = otherButtonBlock;

        [self setupDefaultUIProperty];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message textFieldMessage:(NSString *)textFieldMessage textFieldValue:(NSString *)textFieldValue cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelButtonBlock:(WFAlertViewCancelBlock)cancelButtonBlock textFieldBlock:(WFAlertViewTextFieldBlock)textFieldBlock
{
    _textFieldBlock = textFieldBlock;
    _type = WFAlertViewTypeTextField;
    
    _textFieldMessage = textFieldMessage;
    _textFieldValue = textFieldValue;
    
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles cancelButtonBlock:cancelButtonBlock otherButtonBlock:nil];
}

- (void)setupDefaultUIProperty
{
    //init property
    _backgroundViewColor = kBackgroundColor;
    _titleColor = kTitleColor;
    _messageColor = kMessageColor;
    _cancelButtonColor = kCancelButtonColor;
    _otherButtonColor = kOtherButtonColor;
    _textFieldTextColor = kMessageColor;
    _titleBGViewColor = kTitleBGViewColor;
    
    
    _titleFont = kTitleFont;
    _messageFont = kMessageFont;
    _cancelButtonFont = kCancelButtonFont;
    _otherButtonFont = kOtherButtonFont;
    _textFieldTextFont = kMessageFont;
    
    _animationDuration = kAnimationDuration;
    _animationSpringLevel = kAnimationSpringLevel;
    
    _alertViewWidth = kAlertViewWidth;
    
    _textFieldBorderColor = _textFieldTextColor;
    _textFieldBorderWidth = kTextFieldBorderWidth;
    _textFieldHeight = kButtonHeight;
    _buttonHeight = kButtonHeight;
    
    _messageTextAlignment = NSTextAlignmentCenter;

    _viewCornerRadius = kViewCornerRadius;
    _buttonCornerRadius = kButtonCornerRadius;
    
    _marginInsets = UIEdgeInsetsMake(kTopMargin, kLeftRightMargin, kBottomMargin, kLeftRightMargin);
    _title2messageMargin = kMargin;
    _message2ButtonMargin = kMargin;
    _buttonHorizontalMargin = kMargin;
    _buttonVerticalMargin = kMargin;
    
    

}


- (void)setMargin:(UIEdgeInsets)margin
{
    _marginInsets = margin;
    
    _leftMargin = margin.left;
    _rightMargin = margin.right;
    _topMargin = margin.top;
    _bottomMargin = margin.bottom;
}


//- (void)setTintColor:(UIColor *)tintColor{}

- (void)layoutSubviews
{
    [self setupView];
    
    [self setupTitle:_title];
    
    [self setupMessage:_message];
    
    if (self.type == WFAlertViewTypeTextField) {
        [self addTextField];
    }
    
    [self setupButton];
    
    [self setupXButton];
    
    [self adjustViewHeight];
}

- (void)setupView
{
    self.backgroundColor = _backgroundViewColor;
    self.layer.cornerRadius = _viewCornerRadius;
}

- (void)setupXButton
{
    if (_showXButton) {
        
        UIButton *xButton = [UIButton new];
        xButton.frame = CGRectMake(0, 0, 40, 40);
        xButton.backgroundColor = [UIColor redColor];
        [xButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:xButton];
        
        xButton.x = self.widthOfView - xButton.widthOfView + _xButtonPositionInsets.right;
        xButton.y = -_xButtonPositionInsets.top;
    }
}



- (void)addTextField
{
    if (_textField == nil) {
        WFAlertViewTextField *textField = [WFAlertViewTextField new];
        CGFloat textFieldY = [self messageMaxY] + kMargin;
        textField.frame = CGRectMake(_marginInsets.left, textFieldY, self.widthOfView - _marginInsets.left - _marginInsets.right, _textFieldHeight);
        textField.layer.borderWidth = _textFieldBorderWidth;
        textField.layer.borderColor = [_textFieldBorderColor CGColor];
        textField.placeholder = _textFieldMessage;
        textField.text =  _textFieldValue;
        textField.font = _textFieldTextFont;
        textField.textColor = _textFieldTextColor;
        textField.textContainerInset = UIEdgeInsetsMake(0, kTextFieldLeftInset, 0, 0);
        textField.leftView.backgroundColor = [UIColor redColor];
         textField.returnKeyType = UIReturnKeyDone;
         textField.delegate = self;
        _textField = textField;
        [self addSubview:textField];
        
        if (![_textField isFirstResponder]) {
            [_textField becomeFirstResponder];
        }
        
//        [textField setSelectedTextRange:[_textField textRangeFromPosition:_textField.beginningOfDocument toPosition:_textField.endOfDocument]];
    }
}

#pragma mark - UITextFiledDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self otherButtonClick:nil];
    
    return YES;
}

- (void)setupTitle:(NSString *)title
{
    if (_titleLabel == nil && title.length) {
        
        
        
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = title;
        titleLabel.font = _titleFont;
        titleLabel.textColor = _titleColor;
        CGRect titleRect = [title boundingRectWithSize:CGSizeMake(self.widthOfView - _marginInsets.left - _marginInsets.right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _titleFont} context:0];
        titleLabel.frame = titleRect;
        titleLabel.centerX = self.frame.size.width/2;
        titleLabel.y = _marginInsets.top;
        
        if (_showTitleBG) {
            UIView *titleView = [UIView new];
            [self addSubview:titleView];
            titleView.backgroundColor = _titleBGViewColor;
            titleView.frame = CGRectMake(0, 0, self.widthOfView, 0);
            
            UIView *line = [UIView new];
            line.backgroundColor = kTitleBGLineColor;
            line.frame = CGRectMake(0, 0, self.widthOfView, 0.5);
            [titleView addSubview:line];
            
            titleView.heightOfView = titleRect.size.height + _marginInsets.top + _title2messageMargin;
            line.y = titleView.size.height - 0.5;
        }
        
            _titleLabel = titleLabel;
        [self addSubview:titleLabel];
    }
}


- (void)setupMessage:(NSString *)message
{
    if (_messageLabel == nil && message.length) {
        
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = message;
        messageLabel.font = _messageFont;
        messageLabel.textColor = _messageColor;
        messageLabel.numberOfLines = 0;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textAlignment = _messageTextAlignment;
        CGRect messageRect = [message boundingRectWithSize:CGSizeMake(self.widthOfView - _marginInsets.left - _marginInsets.right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _messageFont} context:0];
        messageLabel.frame = CGRectMake(_marginInsets.left, 0, self.widthOfView - _marginInsets.left - _marginInsets.right, messageRect.size.height);
        messageLabel.centerX = self.frame.size.width/2;
        
        if (_titleLabel == nil) {
            messageLabel.y = _marginInsets.top;
        }else {
            if (_showTitleBG) {
                messageLabel.y = CGRectGetMaxY(_titleLabel.frame) + _title2messageMargin + kMargin/2;
            }else {
                messageLabel.y = CGRectGetMaxY(_titleLabel.frame) + _title2messageMargin;
            }
        }
        
        _messageLabel = messageLabel;
        [self addSubview:messageLabel];
    }
}


- (CGFloat)messageMaxY
{
    if (_type == WFAlertViewTypeNormal) {
        if (_titleLabel == nil) {
            return CGRectGetMaxY(_messageLabel.frame);
        }else if (_messageLabel == nil) {
            return CGRectGetMaxY(_titleLabel.frame);
        }else if (_textField == nil) {
            return CGRectGetMaxY(_messageLabel.frame);
        }else {
            return CGRectGetMaxY(_textField.frame);
        }
    }else {
        if (_textField == nil) {
            if (_titleLabel == nil) {
                return CGRectGetMaxY(_messageLabel.frame);
            }else if (_messageLabel == nil) {
                return CGRectGetMaxY(_titleLabel.frame);
            }else {
                return CGRectGetMaxY(_messageLabel.frame);
            }
        }else {
            return CGRectGetMaxY(_textField.frame);
        }
    }
}


- (void)setupButton
{
    if (_cancelButtonTitle) {
        [self addCancelButton];
    }
    
    if (_otherButtonTitles.count == 0) {
        //return
    }else {
       [self addOtherButton];
    }
}


- (void)addCancelButton
{
    if (_cancelButton == nil) {
        UIButton *cancelButton = [UIButton new];
        cancelButton.backgroundColor = _cancelButtonColor;
        cancelButton.tag = -1;
        cancelButton.layer.cornerRadius = _buttonCornerRadius;
        [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        cancelButton.titleLabel.font = _cancelButtonFont;
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = cancelButton;
        [self addSubview:cancelButton];
        
        CGFloat buttonY = [self messageMaxY] + _message2ButtonMargin;
        NSLog(@"%f",[self messageMaxY]);
        NSLog(@"%f",buttonY);
        cancelButton.frame = CGRectMake(_marginInsets.left, buttonY, self.widthOfView - _marginInsets.left - _marginInsets.right, _buttonHeight);
    }
}



- (void)addOtherButton
{
    if (_otherButtons == nil) {
        _otherButtons = [NSMutableArray arrayWithCapacity:_otherButtonTitles.count];
    }

    if (_otherButtons.count == 0) {
        
        for (int i=0; i<_otherButtonTitles.count; i++) {
            
            NSString *otherTitle = _otherButtonTitles[i];
            
            UIButton *otherButton = [UIButton new];
            otherButton.backgroundColor = _otherButtonColor;
            otherButton.titleLabel.font = _otherButtonFont;
            otherButton.layer.cornerRadius = _buttonCornerRadius;
            otherButton.tag = i;
            [otherButton setTitle:otherTitle forState:UIControlStateNormal];
            [otherButton addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_otherButtons addObject:otherButton];
            [self addSubview:otherButton];
            if (i == _otherButtonTitles.count - 1) {
                _lastButton = otherButton;
            }
            
            if (_cancelButton) {
                _lastButton = _cancelButton;
            }
            
            if (_buttonType == WFAlertViewButtonTypeHorizontal) {
                
                if (_cancelButton && _otherButtonTitles.count == 1) {
                    //水平排列
                    CGFloat buttonW = (self.widthOfView - _marginInsets.left - _marginInsets.right - _buttonHorizontalMargin)/2;
                    CGFloat rightX = _marginInsets.left + buttonW + _buttonHorizontalMargin;
                    _cancelButton.frame = CGRectMake(_marginInsets.left, _cancelButton.y, buttonW, _buttonHeight);
                    otherButton.frame = CGRectMake(rightX, _cancelButton.y, buttonW, _buttonHeight);
                    
                }else if (_cancelButton == nil && _otherButtonTitles.count == 2) {
                    //水平排列
                    CGFloat buttonW = (self.widthOfView - _marginInsets.left - _marginInsets.right - _buttonHorizontalMargin)/2;
                    CGFloat buttonX = _marginInsets.left + i*(buttonW + _buttonHorizontalMargin);
                    CGFloat buttonY = [self messageMaxY] + _message2ButtonMargin;
                    otherButton.frame = CGRectMake(buttonX, buttonY, buttonW, _buttonHeight);
                }else {
                    //超过两个按钮,转换为竖直排列
                    _buttonType = WFAlertViewButtonTypeVertical;
                    i--;
                    continue;
                }
                
            }else {
                CGFloat buttonY;
                if (_cancelButtonTitle) {
                    buttonY = [self messageMaxY] + _message2ButtonMargin + i*(_buttonVerticalMargin + _buttonHeight);
                    CGFloat cancelButtonY = buttonY + (_buttonVerticalMargin + _buttonHeight);
                    _cancelButton.frame = CGRectMake(_marginInsets.left, cancelButtonY, self.widthOfView - _marginInsets.left - _marginInsets.right, _buttonHeight);
                }else {
                    buttonY = [self messageMaxY] + _message2ButtonMargin + i*(_buttonVerticalMargin + _buttonHeight);
                }
                otherButton.frame = CGRectMake(_marginInsets.left, buttonY, self.widthOfView - _marginInsets.left - _marginInsets.right, _buttonHeight);
            }
        }
    }
}


- (void)otherButtonClick:(UIButton *)sender
{
    if (_otherButtonBlock) {
        _otherButtonBlock(sender.tag);
        [self hide];
        return;
    }
    
    if (_textFieldBlock) {
        _textFieldBlock(_textField);
    }
    [self hide];
}


- (void)cancelButtonClick:(UIButton *)sender
{
    if (_cancelButtonBlock) {
        _cancelButtonBlock();
    }
    
    [self hide];
}


- (void)adjustViewHeight
{
    CGFloat height;
    if (_cancelButtonTitle != nil) {
        if (_otherButtonTitles.count) {
            height = CGRectGetMaxY(_lastButton.frame);
        }else {
            height = CGRectGetMaxY(_cancelButton.frame);
        }
    }else {
        if (_otherButtonTitles.count) {
            height = CGRectGetMaxY(_lastButton.frame);
        }else {
            height = [self messageMaxY];
        }
    }
    self.heightOfView =  height + _marginInsets.bottom;
    self.widthOfView = _alertViewWidth;
    
    self.center = _window.center;
}


- (UIView *)cover
{
    if (_cover == nil) {
        CGRect windowFrame = [[UIScreen mainScreen] bounds];
        UIView *cover = [[UIView alloc]init];
        cover.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cover.frame = windowFrame;
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
        [cover addGestureRecognizer:tap];
        _cover = cover;
    }
    return _cover;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)show
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.cover];
    [window addSubview:self];
    _window = window;
    
    self.center = window.center;
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer:tap];
    
   [UIView animateWithDuration:_animationDuration delay:0 usingSpringWithDamping:_animationSpringLevel initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
       self.cover.alpha = 0.5f;
       self.alpha = 1.0f;
       self.transform = CGAffineTransformMakeScale(1, 1);
   } completion:^(BOOL finished) {
       
   }];
}

- (void)hide
{
    [self hideKeyboard];
    
    [UIView animateWithDuration:_animationDuration/1.5 animations:^{
        self.cover.alpha = 0;
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)hideKeyboard
{
    [_textField resignFirstResponder];
}
@end






//Textfield
@implementation WFAlertViewTextField
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds = [super textRectForBounds:bounds];
    
    CGRect rect = (CGRect){bounds.origin.x + _textContainerInset.left,
        bounds.origin.y + _textContainerInset.top,
        bounds.size.width - _textContainerInset.left - _textContainerInset.right,
        bounds.size.height - _textContainerInset.top - _textContainerInset.bottom};
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end






//Tool
@implementation UIView (WFAlertView)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidthOfView:(CGFloat)widthOfView
{
    CGRect frame = self.frame;
    frame.size.width = widthOfView;
    self.frame = frame;
}

- (CGFloat)widthOfView
{
    return self.frame.size.width;
}

- (void)setHeightOfView:(CGFloat)heightOfView
{
    CGRect frame = self.frame;
    frame.size.height = heightOfView;
    self.frame = frame;
}

- (CGFloat)heightOfView
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end


