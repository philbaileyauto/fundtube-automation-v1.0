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
    ${isLogout}=                Is Element Present      ${LOCATORS.LOGOUT_LINK}
    Run Keyword If  ${isLogout}        Click Element               ${LOCATORS.LOGOUT_LINK}
    Run Keyword If  ${isLogout}        Wait For Visible            ${LOCATORS.LOGOUT_MESSAGE}


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

Delete User By Email     [Arguments]    ${email}
    [Documentation]    Delete User By Email
    ${email} =  Evaluate Data   ${email}

    Navigate To Form            $[config:url.fundtube]
    Open Fundtube and Login     $[config:super.admin.username]      $[config:super.admin.password]
    Click Element               ${LOCATORS.HOMEPAGE_USER_LINK}
    Select From List By Value   ${LOCATORS.USER_FILTER_SELECT}            email
    Input Text                  ${LOCATORS.USER_SEARCH_FIELD}            ${email}
    Click Element               ${LOCATORS.USER_SEARCH_ICON}
    Sleep   2s
    ${isUserPresent}=           Is Element Present      ${LOCATORS.USER_DELETE_LINK}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.USER_DELETE_LINK}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.USER_DELETE_OKAY}
    #Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.HOMEPAGE_USER_LINK}
    #Run Keyword If  ${isUserPresent}        Select From List By Value   ${LOCATORS.USER_FILTER_SELECT}            email
    #Run Keyword If  ${isUserPresent}        Input Text          ${LOCATORS.USER_SEARCH_FIELD}   ${email}
    #Run Keyword If  ${isUserPresent}        Click Element               ${LOCATORS.USER_SEARCH_ICON}
    #Sleep   2s
    #Run Keyword If  ${isUserPresent}        Element Should Not Be Present       ${LOCATORS.USER_DELETE_LINK}



Delete School By Name     [Arguments]    ${schoolName}
    [Documentation]    Delete school By schoolName
    Navigate To Form            $[config:url.fundtube]
    Open Fundtube and Login     $[config:super.admin.username]      $[config:super.admin.password]
    Click Element               ${LOCATORS.HOMEPAGE_SCHOOL_LINK}
    Select From List By Value   ${LOCATORS.SCHOOL_FILTER_SELECT}            title
    Input Text                  ${LOCATORS.SCHOOL_SEARCH_FIELD}            ${schoolName}
    Click Element               ${LOCATORS.SCHOOL_SEARCH_ICON}
    Sleep   2s
    ${isUserPresent}=           Is Element Present              ${LOCATORS.SCHOOL_DELETE_LINK}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.SCHOOL_DELETE_LINK}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.SCHOOL_DELETE_OKAY}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.HOMEPAGE_SCHOOL_LINK}
    Run Keyword If  ${isUserPresent}        Select From List By Value   ${LOCATORS.SCHOOL_FILTER_SELECT}            title
    Run Keyword If  ${isUserPresent}        Input Text          ${LOCATORS.SCHOOL_SEARCH_FIELD}   ${schoolName}
    Run Keyword If  ${isUserPresent}        Click Element       ${LOCATORS.SCHOOL_SEARCH_ICON}
    Sleep   2s
    Run Keyword If  ${isUserPresent}        Element Should Not Be Present       ${LOCATORS.SCHOOL_DELETE_LINK}


Activate User By Email     [Arguments]    ${email}  ${password}
    [Documentation]     activate user by its email
    Open Mail Session   imaps
    Set Mail Auth   imap.gmail.com  ${email}    ${password}
    Set Mail Folder     INBOX
    ${count}=   Get Folder Message Count
    Log     ${count}
    Should Not Be Equal As Integers     ${count}    0   Does not received Email Activation
    ${message} =    Get Message By Subject      Welcome to FundTube!
    ${matches} =   Get Regexp Matches  ${message}      (?<=href=").*?(?=">click here)

    ${href}=    Get From List   ${matches}  0
    Navigate To Form        ${href}
    Delete All Messages

Create Parent User Account
    [Documentation]     create a parent user account
    Click Element                       ${LOCATORS.WEB_SIGN_UP}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_ADMIN_TAB}

    # Enter valid Profile sign up information and select Join
    Input Text                  ${LOCATORS.SIGN_UP_EMAIL_FIELD}                 $[csv:value(input,'EMAIL')]
    Input Text                  ${LOCATORS.SIGN_UP_PASSWORD_FIELD}              $[csv:value(input,'PASSWORD')]
    Input Text                  ${LOCATORS.SIGN_UP_CONFIRM_PASSWORD_FIELD}      $[csv:value(input,'PASSWORD')]
    Input Text                  ${LOCATORS.SIGN_UP_FIRSTNAME_FIELD}             $[csv:value(input,'FIRSTNAME')]
    Input Text                  ${LOCATORS.SIGN_UP_LASTNAME_FIELD}              $[csv:value(input,'LASTNAME')]
    Select From List By Value   ${LOCATORS.SIGN_UP_MONTH_SELECT}                $[csv:value(input,'BIRTH_MONTH')]
    Select From List By Value   ${LOCATORS.SIGN_UP_DAY_SELECT}                  $[csv:value(input,'BIRTH_DAY')]
    Select From List By Value   ${LOCATORS.SIGN_UP_YEAR_SELECT}                 $[csv:value(input,'BIRTH_YEAR')]
    Click Element               ${LOCATORS.SIGN_UP_JOIN_BTN}
    Sleep   2s
    Element Should Be Visible   ${LOCATORS.SIGN_UP_DONOR_TY_MESSAGE}
    Click Element               ${LOCATORS.SIGN_UP_PARENT_OK_BTN}
    Element Should Be Visible   ${LOCATORS.HOMEPAGE_MAIN_IMG}

    # Activation email:
    Activate User By Email      $[csv:value(input,'EMAIL')]     $[csv:value(input,'EMAIL_PASSWORD')]

    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'EMAIL')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}
    Logout To Fundtube


Test Tear Down With Cleanup    [Arguments]    ${email}
    Logout To Fundtube
    Delete User By Email            ${email}
    Delete All Cookies
    Capture Screenshot