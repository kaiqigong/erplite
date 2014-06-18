//
//  ContactsDetailViewController.m
//  ERPLite
//
//  Created by RInz on 14-6-17.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "ContactsDetailViewController.h"
#import "ContactsForm.h"

@implementation ContactsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.formController = [[FXFormController alloc]init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
    self.formController.form = [[ContactsForm alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //reload the table
    [self.tableView reloadData];
}

- (IBAction)BtnCancel:(id)sender {
}

- (IBAction)BtnDone:(id)sender {
}
@end
