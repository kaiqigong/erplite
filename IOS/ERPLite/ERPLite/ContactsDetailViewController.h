//
//  ContactsDetailViewController.h
//  ERPLite
//
//  Created by RInz on 14-6-17.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "FXForms.h"

@interface ContactsDetailViewController : UIViewController <FXFormControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FXFormController *formController;

- (IBAction)BtnCancel:(id)sender;
- (IBAction)BtnDone:(id)sender;

@end
