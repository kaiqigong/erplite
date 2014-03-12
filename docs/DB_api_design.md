1. Contacts
     CRM核心内容，contact可以自由扩展，可以和其他entity关联，用户可以加以评论，其他entity也会按照这样的思想来设计

     1.1 tables

     Contact
     UID
     Name:text 
     Avator:url:头像位置
     Description:text:在list中显示
     Tags:text:主要为了用会能加tag，然后分类管理，*tag可以是多个的，是否放在扩展表呢，需要综合查询逻辑
     InsertTimeStamp:stamp:该字段所有表都要有，在server存储。接下来的表省略该字段
     UpdateTimeStamp:stamp:该字段所有表都要有，在server存储。接下来的表省略该字段

     ContactData
     UID
     ContactUID:text 
     Key:text:如phone，email之类
     Value:text:phone，email的值

     ContactLink
     UID
     ContactUID:text 
     EntityType:text:Buying, Selling, Message, Task
     EntityUID

     ContactComment 对每一个entity都有这样一个表，*是合并在一块呢，还是分开来 
     UID
     ContactUID:text 
     Comment:text:Buying, Selling, Message, Task
     Author
     1.2 api

     *我了解的有两种api形式 
     一 所有api访问统一个url，通过param来区别对应操作 
     {
         userid："cage",
          token：""，
          action:"contacts",
          Param:{
               skip:100,
               Take:100,
          }
     }

     二 通过url区别操作 /contacts

     a. get contact list 
     request 

     response 
     { 
     Status:”200”,
     Result:{
          From:0
          To:99
          Items:[{
               Uid:”xxx”,
               Name:”xxx”,
               Description:”xxx”,
               Avator:”xxx”,
               UpdateTime:”xxx”,
               },
               {
               Uid:”xxx”,
               Name:”xxx”,
               Description:”xxx”,
               Avator:”xxx”,
               UpdateTime:”xxx”,
               },]
         }
     }

     {
          Status:"500",
          Result:"error"
     }


     b. get single contact 
     //todo
