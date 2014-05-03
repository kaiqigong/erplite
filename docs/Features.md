#Contact
##Contact List
###Get all list
###Query
mimic jira
###Pagination

##ContactDetail
###Display
Img  
Data  
Link  
Comment  
Tag  
Attachment  
Assignee  
Navigate to previous, next contact.
        
##Update
Update Img  
Update Data  
Update link  
Add Comment  
Add,Remove Tag  
Add Attachment  
Add Assignee  

##Create
Upload Img  
Create Contact  

##Contact Fields
surname givenname company department title phone mobile fax origin email address birthday region website qq weibo im

#User
根据登录User自动更新createdby, updatedby。  
##Group
创建Group, Group中可以添加User。同一个User可以属于不同的Group。 默认Group: Public，所有用户都在Public中。  
User或者Group将用来做权限控制。

#Task
##Task Fields
uid, name, description, due, status, createdby, crteatedtime, updatedby, updatedtime, owner  
status 为not completed, completed  
due 完成期限，可以为空。  
owner可以specified到某个user或者group，每个人登录只能看到自己的task或者自己group的task。  
##Task Link
与Contact Link相同。 Link到相关的Contact, Order...  
