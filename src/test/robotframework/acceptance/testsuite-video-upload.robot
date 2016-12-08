*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Field Mapping
Test Setup      Set Config And Test Data     web     $[config:upload.video.test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Video Upload Scenario - Parent
    [Tags]       fundtube    regression      video
    [Documentation]     test upload video - parent credentials
    #Get all data from csv file
    Get First Data From CSV     input   valid

    ${random} =         Generate Random String      4      [NUMBERS]
    ${event_name} =     Evaluate Data               $[csv:value(input,'EVENT_NAME')]
    ${event_name} =     Set Variable                ${event_name}-${random}
    ${video_location}=  Get Video File Location     $[csv:value(input,'VIDEO_FILE')]

    Open Frontend Url           $[config:url.dev.fundtube]      $[csv:value(input,'PARENT_USERNAME')]      $[csv:value(input,'PARENT_PASSWORD')]
    Click Element               ${LOCATORS.HOME_VIDEO_UPLOAD_LINK}
    Wait For Visible            ${LOCATORS.UPLOAD_VIDEO_TITLE}

    #fill up upload video information
    Input Text                  ${LOCATORS.EVENT_NAME_FIELD}            ${event_name}
    Click Element               ${LOCATORS.SCHOOL_NAME_LINK}
    Wait For Element            ${LOCATORS.SCHOOL_FILTER_TITLE}
    Click Element By Value      ${LOCATORS.SCHOOL_NAME_VALUE}           $[csv:value(input,'SCHOOL')]
    Click Element               ${LOCATORS.SCHOOL_FILTER_APPLY_BTN}
    Input Text                  ${LOCATORS.EVENT_DESCRIPTION}           $[csv:value(input,'EVENT_DESCRIPTION')]
    Choose File                 ${LOCATORS.SELECT_VIDEO_BTN}            ${video_location}
    Select From List By Value   ${LOCATORS.EVENT_DONATION_SELECT}       $[csv:value(input,'EVENT_DONATION')]
    Select From List By Value   ${LOCATORS.PREVIEW_LENGTH_SELECT}       $[csv:value(input,'PREVIEW_LENGTH')]
    Click Element               ${LOCATORS.UPLOAD_VIDEO_BTN}

    #process uploaded video
    Wait For Element            ${LOCATORS.VIDEO_UPLOAD_SUCCESS_TITLE}
    Click Element               ${LOCATORS.VIDEO_UPLOAD_SUCCESS_OK_BTN}

    #logout parent user
    Click Element               ${LOCATORS.LOGOUT_LINK}
    Wait For Visible            ${LOCATORS.LOGOUT_MESSAGE}
    Sleep   3s


    #Login as admin user
    Open Frontend Url           $[config:url.dev.fundtube]      $[csv:value(input,'ADMIN_USERNAME')]      $[csv:value(input,'ADMIN_PASSWORD')]
    Click Element               ${LOCATORS.SUBMITTED_LINK}
    Click Element By Value      ${LOCATORS.GENERIC_LINK_TITLE_VALUE}    ${event_name}

    #validate uploaded video
    Textfield Value Should Be           ${LOCATORS.EVENT_NAME_FIELD}            ${event_name}
    Element Text Should Be              ${LOCATORS.EVENT_DESCRIPTION}           $[csv:value(input,'EVENT_DESCRIPTION')]
    Element Selected Value Should Be    ${LOCATORS.EVENT_DONATION_SELECT}       $[csv:value(input,'EVENT_DONATION')]
    Element Selected Value Should Be    ${LOCATORS.PREVIEW_LENGTH_SELECT}       $[csv:value(input,'PREVIEW_LENGTH')]

    #provide info for approved video
    Click Element                   ${LOCATORS.SELECT_PREVIEW_IMAGE_BTN}
    Click Element By Value          ${LOCATORS.SELECT_PREVIEW_IMAGE_INDEX}      $[csv:value(input,'SELECT_PREVIEW_IMAGE_INDEX')]
    Click Element                   ${LOCATORS.SELECT_PREVIEW_OK_BTN}
    Element Text Value Should Be    ${LOCATORS.SELECT_PREVIEW_IMAGE_VALUE}      $[csv:value(input,'IMAGE_NAME')]
    Click Element                   ${LOCATORS.APPROVE_CHECKBOX}
    Select From List By Value       ${LOCATORS.FUNDRAISING_GOAL_SELECT}         $[csv:value(input,'GOAL_AMOUNT')]
    Click Element                   ${LOCATORS.APPROVE_VIDEO_BTN}
    Input Text                      ${LOCATORS.APPROVE_VIDEO_FIELD}             $[csv:value(input,'UPLOADER_NOTE')]
    Click Element                   ${LOCATORS.APPROVE_VIDEO_CONFIRM_BTN}

    #verify and watch video
    Click Element                   ${LOCATORS.FUNDTUBE_LOGO}
    Click Element                   ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    Element Text Value Should Be    ${LOCATORS.GENERIC_LINK_TITLE_VALUE}      ${event_name}