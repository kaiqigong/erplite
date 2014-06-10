//
//  MainViewController.h
//  
//
//  Created by RInz on 14-6-1.
//
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"

@interface LoginViewController : UIViewController<RegisterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)Login:(UIButton *)sender;
- (IBAction)GoToRegisterPage:(UIButton *)sender;
- (IBAction)NextPassword:(id)sender;
- (IBAction)NextLogin:(id)sender;
- (IBAction)MainView_TouchDown:(id)sender;


@end
