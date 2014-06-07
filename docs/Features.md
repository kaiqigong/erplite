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
uid, name, description, due, status, priority, owner, createdby, crteatedtime, updatedby, updatedtime
status 为open, closed
due 完成期限，可以为空，为空表示没有期限。
priority 为high, medium, low
owner可以specified到某个user或者group，每个人登录只能看到自己的task或者自己group的task。  
##Task Link
与Contact Link相同。 Link到相关的Contact, Order...  
##Task Comments, Tags, Attachments, Assignment 同Contact。

#Tag
##Create new tags
System should record all the tags input and provide suggestions, like auto complete, when user typing.  
Finish typing the tag by press enter/tab/out of focus. Cancel typing by press esc.  
##Can delete or edit the tags
##Query by tags
List all the popular tags, and once click the tag, will quick filter the items.

#Event
##Event Fields
uid, name, description, location, start, end, originator, attendee, recurrence, tag, link, comment, attachment
description nullable
location nullable
attendee  参与者，1对多，所有参与者可以看到该event。不可以修改删除。可以自己退出该event
originator  发起人，1:1，发起人可以邀请参与者。可以删除，修改event
recurrence nullable 一种数据格式，如果有值，表示此event为定期事件。"RRULE:FREQ=WEEKLY;UNTIL=20110701T100000-07:00"
##Mimic [Google Calendar api](https://developers.google.com/google-apps/calendar/)

#Product
根据行业细分，此处以旅游行业。 
##Product Fields
uid, name, description, category, provider, duration (days), destination, departure, detail  

##Stocking
Product 1-n Stocking
uid, productId, quantity, price, departureDate, isAdult, combo

#Sales
##Order
uid, customerId, orderTime, isConfirmed, isPaid, isDelivered, isAppraised, rates, comments  
##OrderItem
uid, orderId, productId,productName,productDescription, quantity, price, departureDate, isAdult

