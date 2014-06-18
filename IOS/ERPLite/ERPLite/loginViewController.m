//
//  LoginViewController.m
//  
//
//  Created by RInz on 14-6-1.
//
//

#import "LoginViewController.h"
#import <ASIFormDataRequest.h>
#import <SVProgressHUD.h>
#import <JSONKit.h>
#import "Constants.h"
#import "ERPLite-Swift.h"

@interface LoginViewController (){
}

@end

@implementation LoginViewController

@synthesize username;
@synthesize password;
@synthesize loginButton;

BOOL _isBack = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    if (!_isBack) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString *access_token = [userDefaultes stringForKey:@"access_token"];
        NSString *accessToken = [NSString stringWithFormat:@"Bearer %@", access_token];
    
        NSURL *url_login = [NSURL URLWithString:kRootURL];
        ASIHTTPRequest *requestLogin = [ASIHTTPRequest requestWithURL:url_login];
        [requestLogin addRequestHeader:@"Authorization" value:accessToken];
        [SVProgressHUD show];
        [requestLogin startSynchronous];
        NSData *responseData = [requestLogin responseData ];
        JSONDecoder *jd = [[JSONDecoder alloc] init];
        NSDictionary *result = [jd objectWithData:responseData];
        if ([result objectForKey:@"status_code"] != nil) {
            [SVProgressHUD showErrorWithStatus:[result objectForKey:@"detail"]];
        }
        else{
            [SVProgressHUD showSuccessWithStatus:@"Success"];
            [self performSegueWithIdentifier:@"login" sender:self];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"register"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        RegisterViewController *registerViewController = [navigationController viewControllers][0];
        registerViewController.delegate = self;
    }
//    if ([segue.identifier isEqualToString:@"login"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        MainViewController *mainViewController = [navigationController viewControllers][0];
//    }
}


- (IBAction)Login:(UIButton *)sender {
    NSURL *url_access_token = [NSURL URLWithString:kAccessURL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url_access_token];
    [request setPostValue:username.text forKey:@"username"];
    [request setPostValue:password.text forKey:@"password"];
    [request setPostValue:kClientID forKey:@"client_id"];
    [request setPostValue:kClientSecrect forKey:@"client_secret"];
    [request setPostValue:@"password" forKey:@"grant_type"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    [SVProgressHUD show];
}

- (IBAction)GoToRegisterPage:(UIButton *)sender {
}

- (IBAction)NextPassword:(id)sender {
    [self.password becomeFirstResponder];
}

- (IBAction)NextLogin:(id)sender {
    [sender resignFirstResponder];
    [self.loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)MainView_TouchDown:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString* access_token;
    NSString* expires_in;
    NSString* scope;
    
    NSData *responseData = [request responseData];
    JSONDecoder *jd = [[JSONDecoder alloc] init];
    NSDictionary *result = [jd objectWithData:responseData];
    
    if ([result objectForKey:@"error"] == nil) {
        access_token = result[@"access_token"];
        expires_in = result[@"expires_in"];
        scope = result[@"scope"];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:access_token forKey:@"access_token"];
        [userDefaults setObject:expires_in forKey:@"expire_in"];
        [userDefaults setObject:scope forKey:@"scope"];
        [userDefaults synchronize];

        [SVProgressHUD showSuccessWithStatus:@"Success!"];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"Invalid Username or Password!"];
    }
    
    
}

- (void)RegisterViewControllerDidBack:(RegisterViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
    _isBack=YES;
}



@end
