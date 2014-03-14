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
     ContactUID::链接Contact的UID 
     Key:text:如phone，email之类
     Value:text:phone，email的值

     ContactLink
     UID
     ContactUID::链接Contact的UID  
     EntityType:text:Buying, Selling, Message, Task
     EntityUID

     ContactComment 对每一个entity都有这样一个表，*是合并在一块呢，还是分开来 
     UID
     ContactUID::链接Contact的UID 
     Comment:text:Buying, Selling, Message, Task
     AuthorUID::评论者的id
     
     ContactAttachment 存储附件信息，文件名，路径，大小，上传者，*要注意的是文件在server上的保存方式，以及下载方式。 (next step)
     UID
     ContactUID::链接Contact的UID 
     AttachmentUID::链接Attachment的UID
     
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
     //todo 

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
               lastModifiedTime:”xxx”,
               },
               {
               Uid:”xxx”,
               Name:”xxx”,
               Description:”xxx”,
               Avator:”xxx”,
               lastModifiedTime:”xxx”,
               },]
         }
     }

     {
          Status:"500",
          Result:"error"
     }


     b. get single contact 
     request
     //todo
     
     response
     主要思想是，data作为contact的info属性，links，comments，attachments作为collection
     {
         "id":1,
         "name":"凯奇",
         "avator":"./img/128px/bag_128px.png",
         "description":"前端开发",
         "lastModifiedTime":"2014/03/11",
         "tags":["hello","world"],
         "info":{
	         "fullname":"凯奇",
	         "company":"自由开发者",
	         "phone":"021-87654321",
	         "mobile":"18612345678",
	         "email":"ca@afd.com",
	         "address":"贝克街211B",
         },
         "links":[{
               "id":5，
               "type":"Supplier",
               "name":"Apple Inc",
               "lastModifiedTime":"2014/03/11",
            },
            {
               "id":5，
               "type":"Task",
               "name":"一起吃晚饭",
               "lastModifiedTime":"2014/03/11",
            }],
         "comments":[{
               "id":1，
               "comment":"你要请他吃大餐，他才愿意与你合作"，
               "author":"cage",
               "lastModifiedTime":"2014/03/11",
            },
            {
               "id":2，
               "comment":"你还要请他去游乐场！"，
               "author":"young",
               "lastModifiedTime":"2014/03/11"
            }]，
         "attachments":[{
               "id":1，
               "filename":"苹果报价单.xls"，
               "size":798,
               "download":"download:",
               "lastModifiedTime":"2014/03/11",
            },
            {
               "id":1，
               "filename":"苹果说明书.doc"，
               "size":600,
               "download":"download:",
               "lastModifiedTime":"2014/03/11",
            }]，	
      }


2. Attachment(next step)
     保存附件信息
     
     2.1 tables
     
     Attachment
     UID
     Filename:text:文件保存时候的名字
     Path::文件的下载地址
     Size:number:存kb
     AuthorUID::上传者的id
     
     2.2 技术细节
     server上的路径肯定不能作为公开url暴露，下载者也要有权限控制
     //todo
     

     