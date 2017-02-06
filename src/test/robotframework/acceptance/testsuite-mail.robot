*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Config And Test Data    web     $[config:test.data]
Test Teardown   Test Tear Down

*** Test Cases ***
Test Email
    [Tags]       email
    [Documentation]     test email retrieval
    Open Mail Session   imaps
    Set Mail Auth   imap.gmail.com  test.fundtube@gmail.com     test1234!@#$
    Set Mail Folder     INBOX
    ${count}=   Get Folder Message Count
    Log     ${count}
    ${message} =    Get Message By Subject      Welcome to FundTube!

    ${href} =   Get Regexp Matches  ${message}      (?<=href=").*?(?=">click here)
    Log     ${href}


Test Delete
   [Tags]       delete
   [Documentation]     delete user
    Delete User By Email     	sdfsdf@gmail.com


Test Email
    [Tags]       activate
    [Documentation]     test email retrieval