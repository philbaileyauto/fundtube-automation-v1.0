*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Config And Test Data        web     $[config:upload.video.test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Video Upload Scenario - Parent
    [Tags]       parent    regression      video
    [Documentation]     test upload video - parent credentials
    #Get all data from csv file
    Get First Data From CSV     input   valid

    ${random} =         Generate Random String      4      [NUMBERS]
    ${event_name} =     Evaluate Data               $[csv:value(input,'EVENT_NAME')]
    ${event_name} =     Set Variable                ${event_name}-${random}
    ${video_location}=  Get Video File Location     $[csv:value(input,'VIDEO_FILE')]

    #navigate to fundtube and upload video
    Open Fundtube and Login     $[csv:value(input,'PARENT_USERNAME')]      $[csv:value(input,'PARENT_PASSWORD')]
    Upload Video As Parent      ${event_name}   ${video_location}

    #logout parent user
    Logout To Fundtube

    #Login as admin user and approve submitted/uploaded video
    Open Fundtube and Login     $[csv:value(input,'ADMIN_USERNAME')]      $[csv:value(input,'ADMIN_PASSWORD')]
    Approve Uploaded Video      ${event_name}

    #verify and watch video
    Click Element               ${LOCATORS.FUNDTUBE_LOGO}
    Verify Uploaded Video       ${event_name}


Video Upload Scenario - Admin
    [Tags]       admin    regression      video  admin
    [Documentation]     test upload video - admin credentials
    #Get all data from csv file
    Get First Data From CSV     input   valid

    ${random} =         Generate Random String      4      [NUMBERS]
    ${event_name} =     Evaluate Data               $[csv:value(input,'EVENT_NAME')]
    ${event_name} =     Set Variable                ${event_name}-${random}
    ${video_location}=  Get Video File Location     $[csv:value(input,'VIDEO_FILE')]

    #navigate to fundtube and upload video
    Open Fundtube and Login     $[csv:value(input,'ADMIN_USERNAME')]      $[csv:value(input,'ADMIN_PASSWORD')]
    Upload Video As Admin       ${event_name}       ${video_location}

    #approve submitted/uploaded video
    Approve Uploaded Video      ${event_name}

    #verify and watch video
    Click Element               ${LOCATORS.FUNDTUBE_LOGO}
    Verify Uploaded Video       ${event_name}