//
//  ContactsForm.m
//  ERPLite
//
//  Created by RInz on 14-6-17.
//  Copyright (c) 2014年 RInz. All rights reserved.
//

#import "ContactsForm.h"

@implementation ContactsForm

- (NSArray *)fields{
    return @[@"avator",
             @"surname",
             @"givenname",
             @"company",
             @"department",
             @"title",
             @{FXFormFieldKey: @"phone", FXFormFieldType: FXFormFieldTypeNumber},
             @{FXFormFieldKey: @"mobile", FXFormFieldType: FXFormFieldTypeNumber},
             @{FXFormFieldKey: @"fax", FXFormFieldType: FXFormFieldTypeNumber},
             @"origin",
             @"email",
             @"address",
             @"birthday",
             @"region",
             @{FXFormFieldKey: @"website", FXFormFieldType: FXFormFieldTypeEmail},
             @{FXFormFieldKey: @"qq", @"textLabel.text":@"QQ", FXFormFieldType: FXFormFieldTypeNumber},
             @{FXFormFieldKey: @"weibo", FXFormFieldType: FXFormFieldTypeEmail},
             @"im"
             ];
}

@end
