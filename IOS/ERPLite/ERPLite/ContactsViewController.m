//
//  ContactsViewController.m
//  ERPLite
//
//  Created by RInz on 14-6-13.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "ContactsViewController.h"
#import "Constants.h"
#import "Contacts.h"
#import <ASIFormDataRequest.h>
#import <SVProgressHUD.h>
#import <JSONKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation ContactsViewController


- (void)viewDidLoad{
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
    [self getContacts];
}

- (IBAction)Back:(id)sender {
    [self.delegate ContactsViewControllerDidBack:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    Contacts *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.modifiedDate;
    
//    NSURL *avatorURL = [NSURL URLWithString:contact.avatorURL];
//    NSData *data = [NSData dataWithContentsOfURL:avatorURL];
//    UIImage *avatorimage = [[UIImage alloc] initWithData:data];
//    [cell.imageView setImage:avatorimage];
    [cell.imageView setImageWithURL:[NSURL URLWithString:contact.avatorURL]
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"goToContactDetail" sender:self];
}

- (void)getContacts{
    NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:10];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [userDefaultes stringForKey:@"access_token"];
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@", access_token];
    
    NSURL *url_login = [NSURL URLWithString:kContactListURL];
    ASIHTTPRequest *requestLogin = [ASIHTTPRequest requestWithURL:url_login];
    [requestLogin addRequestHeader:@"Authorization" value:accessToken];
    [requestLogin startSynchronous];
    NSData *responseData = [requestLogin responseData ];
    JSONDecoder *jd = [[JSONDecoder alloc] init];
    NSDictionary *result = [jd objectWithData:responseData];
    if ([result objectForKey:@"status_code"] != nil) {
    }
    else{
        for (NSDictionary *json in result[@"results"]){
            Contacts *contact = [[Contacts alloc]init];
            contact.name = json[@"name"];
            contact.avatorURL = json[@"avator"];
            contact.detailURL = json[@"url"];
            contact.modifiedDate = json[@"modifiedDate"];
            [contacts addObject:contact];
        }
        self.contacts = contacts;
    }
    [self.contactsTableView reloadData];
}

- (IBAction)AddContact:(id)sender {
}
@end
