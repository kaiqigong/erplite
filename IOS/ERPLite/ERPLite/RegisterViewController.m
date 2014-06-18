//
//  RegisterViewController.m
//  ERPLite
//
//  Created by RInz on 14-6-1.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "RegisterViewController.h"
#import <ASIFormDataRequest.h>
#import <SVProgressHUD.h>
#import <JSONKit.h>
#import "Constants.h"
#import "ERPLite-Swift.h"

@interface RegisterViewController ()
{
    UITextField *currTextField;
}

@end

@implementation RegisterViewController

@synthesize username;
@synthesize email;
@synthesize password1;
@synthesize password2;
@synthesize scrollview;

//---size of keyboard---
CGRect keyboardBounds;

//---size of application screen---
CGRect applicationFrame;

//---original size of ScrollView---
CGSize scrollViewOriginalSize;

- (void)moveScrollView:(UIView *) theView {
	
	NSLog(@"%f", keyboardBounds.size.height);
	
	
    //---get the y-coordinate of the view---
    CGFloat viewCenterY = theView.center.y;
    
    //---calculate how much visible space is left---
    CGFloat freeSpaceHeight = applicationFrame.size.height - keyboardBounds.size.height;
    
    //---calculate how much the scrollview must scroll---
    CGFloat scrollAmount = viewCenterY - freeSpaceHeight / 2.0;
    
    if (scrollAmount < 0)  scrollAmount = 0;
	
    //---set the new scrollView contentSize---
    scrollview.contentSize = CGSizeMake(applicationFrame.size.width,
										applicationFrame.size.height +
										keyboardBounds.size.height);
    
    //---scroll the ScrollView---
    [scrollview setContentOffset:CGPointMake(0, scrollAmount) animated:YES];
}

//---when a TextField view begins editing---
- (void)textFieldDidBeginEditing:(UITextField *)textFieldView {
	currTextField = textFieldView;
    [self moveScrollView:textFieldView];
}

//---when a TextField view is done editing---
- (void)textFieldDidEndEditing:(UITextField *) textFieldView {
    [UIView beginAnimations:@"back to original size" context:nil];
    scrollview.contentSize = scrollViewOriginalSize;
    [UIView commitAnimations];
}

-(void) keyboardWillShow:(NSNotification *) notification{
    //---gets the size of the keyboard---
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    [keyboardValue getValue:&keyboardBounds];
	[self moveScrollView:currTextField];
}

//---when the keyboard disappears---
-(void) keyboardWillHide:(NSNotification *) notification{
}

-(void) viewWillAppear:(BOOL)animated{
    //---registers the notifications for keyboard---
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(keyboardWillShow:)
	 name:UIKeyboardWillShowNotification
	 object:self.view.window];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(keyboardWillHide:)
	 name:UIKeyboardWillHideNotification
	 object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillShowNotification
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:UIKeyboardWillHideNotification
	 object:nil];
}

- (void)viewDidLoad
{
    scrollViewOriginalSize = scrollview.contentSize;
    applicationFrame = [[UIScreen mainScreen] applicationFrame];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
}


- (IBAction)Back:(id)sender {
    [self.delegate RegisterViewControllerDidBack:self];
}

- (IBAction)Register:(UIButton *)sender {
    if ([password1.text isEqualToString:password2.text]) {
        NSURL *url_register = [NSURL URLWithString:@"http://54.255.168.161/account/register"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url_register];
        [request setPostValue:username.text forKey:@"username"];
        [request setPostValue:password1.text forKey:@"password"];
        [request setPostValue:email.text forKey:@"email"];
        [request setDelegate:self];
        [request startAsynchronous];
        [SVProgressHUD show];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    JSONDecoder *jd = [[JSONDecoder alloc] init];
    NSDictionary *result = [jd objectWithData:responseData];
    if ([[result objectForKey:@"status_code"] isEqualToString:@"201"]) {
        [SVProgressHUD showSuccessWithStatus:[result objectForKey:@"detail"]];
        [self performSegueWithIdentifier:@"loginAfterRegister" sender:self];
    }else if ([[result objectForKey:@"status_code"] isEqualToString:@"400"]){
        [SVProgressHUD showErrorWithStatus:[result objectForKey:@"detail"]];
    }else if ([[result objectForKey:@"status_code"] isEqualToString:@"409"]){
        [SVProgressHUD showErrorWithStatus:[result objectForKey:@"detail"]];
    }
}

- (IBAction)NextToEmail:(id)sender {
    [self.email becomeFirstResponder];
}

- (IBAction)NextToPassword1:(id)sender {
    [self.password1 becomeFirstResponder];
}

- (IBAction)NextToPassword2:(id)sender {
    [self.password2 becomeFirstResponder];
}

- (IBAction)NextToRegister:(id)sender {
    [sender resignFirstResponder];
    [self.registerButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)RegisterView_TouchDown:(id)sender {
    [self.view endEditing:YES];
}
@end
