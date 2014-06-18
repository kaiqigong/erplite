//
//  ContactsViewController.h
//  ERPLite
//
//  Created by RInz on 14-6-13.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsViewController;

@protocol ContactsViewControllerDelegate <NSObject>

- (void)ContactsViewControllerDidBack:(ContactsViewController *)controller;

@end

@interface ContactsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<ContactsViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *Back;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;

@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) NSMutableData *data;

- (IBAction)Back:(id)sender;
- (IBAction)AddContact:(id)sender;

@end
