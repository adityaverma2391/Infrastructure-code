@echo off 
set list=01 03 04 10 12 14
(for %%a in (%list%) do ( 
    
   start chrome http://prd-atao-vm%%a.corp.unicru.com:8080/index.jsp?applicationname=admin

))