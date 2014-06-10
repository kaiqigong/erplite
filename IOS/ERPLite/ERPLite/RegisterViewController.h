//
//  RegisterViewController.h
//  ERPLite
//
//  Created by RInz on 14-6-1.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

- (void)RegisterViewControllerDidBack:(RegisterViewController *) controller;

@end

@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) id<RegisterViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

- (IBAction)Back:(id)sender;

- (IBAction)Register:(UIButton *)sender;
- (IBAction)NextToEmail:(id)sender;
- (IBAction)NextToPassword1:(id)sender;
- (IBAction)NextToPassword2:(id)sender;
- (IBAction)NextToRegister:(id)sender;
- (IBAction)RegisterView_TouchDown:(id)sender;

@end
