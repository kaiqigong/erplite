//
//  ContactsForm.h
//  ERPLite
//
//  Created by RInz on 14-6-17.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms/FXForms.h>

@interface ContactsForm : NSObject<FXForm>

@property (strong, nonatomic) UIImage *avator;
@property (copy, nonatomic) NSString *surname;
@property (copy, nonatomic) NSString *givenname;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *department;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *fax;
@property (copy, nonatomic) NSString *origin;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSDate *birthday;
@property (copy, nonatomic) NSString *region;
@property (copy, nonatomic) NSString *website;
@property (copy, nonatomic) NSString *qq;
@property (copy, nonatomic) NSString *weibo;
@property (copy, nonatomic) NSString *im;


@end
