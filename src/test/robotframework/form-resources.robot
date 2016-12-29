*** Settings ***
Library     JSpringBotGlobal
Library     String
Library     Collections

*** Variables ***
${POLL_MILLIS}      500
${TIMEOUT_MILLIS}    10000
${MAX_RESULT_DISPLAY}    250


*** Keywords ***
Open Fundtube
    [Documentation]    open funtube website
    Navigate To Form        $[config:url.fundtube]

Open Fundtube and Login     [Arguments]     ${username}      ${password}
    [Documentation]    Login to fundtube
    Navigate To Form        $[config:url.fundtube]
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           ${username}
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        ${password}
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

Logout To Fundtube
    [Documentation]    Logout to fundtube
    Click Element               ${LOCATORS.LOGOUT_LINK}
    Wait For Visible            ${LOCATORS.LOGOUT_MESSAGE}


Upload Video As Admin     [Arguments]    ${event_name}      ${video_location}
    [Documentation]    Upload video as admin user
    Click Element               ${LOCATORS.HOME_VIDEO_UPLOAD_LINK}
    Wait For Visible            ${LOCATORS.UPLOAD_VIDEO_TITLE}

    #fill up upload video information
    Input Text                  ${LOCATORS.EVENT_NAME_FIELD}            ${event_name}
    Input Text                  ${LOCATORS.EVENT_DESCRIPTION}           $[csv:value(input,'EVENT_DESCRIPTION')]
    Choose File                 ${LOCATORS.SELECT_VIDEO_BTN}            ${video_location}
    Select From List By Value   ${LOCATORS.EVENT_DONATION_SELECT}       $[csv:value(input,'EVENT_DONATION')]
    Select From List By Value   ${LOCATORS.PREVIEW_LENGTH_SELECT}       $[csv:value(input,'PREVIEW_LENGTH')]
    Select From List By Value   ${LOCATORS.FUNDRAISING_GOAL_SELECT}     $[csv:value(input,'GOAL_AMOUNT')]

    #process uploaded video
    Click Element               ${LOCATORS.UPLOAD_VIDEO_BTN}
    Wait For Element            ${LOCATORS.VIDEO_UPLOAD_SUCCESS_TITLE}
    Click Element               ${LOCATORS.VIDEO_UPLOAD_SUCCESS_OK_BTN}


Upload Video As Parent     [Arguments]    ${event_name}      ${video_location}
    [Documentation]    Upload video as parent user
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


Approve Uploaded Video     [Arguments]    ${event_name}
    [Documentation]    Approve uploaded video as admin user
    Sleep   20s
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


Verify Uploaded Video     [Arguments]    ${event_name}
    [Documentation]    Verify uploaded video and play it
    Click Element                   ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    Element Text Value Should Be    ${LOCATORS.GENERIC_LINK_TITLE_VALUE}      ${event_name}

    ${locator}=     Replace String          ${LOCATORS.GET_VIDEO_HREF_BY_LABEL}  VALUE   ${event_name}
    ${href_url}=    Get Element Attribute   ${locator}

    Click Element By Value      ${LOCATORS.VIDEO_SET_TO_PLAY_BTN}   ${href_url}
    Element Should Be Visible   ${LOCATORS.VIDEO_IN_PAUSE}
    Click Element               ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible   ${LOCATORS.VIDEO_IN_PLAY}