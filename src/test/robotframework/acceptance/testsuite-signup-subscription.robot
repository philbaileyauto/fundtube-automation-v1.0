*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Config And Test Data    web     $[config:signup.test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Validation Signup And Subscription 1
    [Tags]      regression      subscription
    [Documentation]     Not Logged In:  Nav between Login and Sign Up
    #navigate to fundtube
    Open Fundtube

    #navigate between Login and Sign Up modal
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.PREVIEW_LOGIN_BTN}
    Element Should Be Visible           ${LOCATORS.WEB_LOGIN_TITLE}
    Click Element                       ${LOCATORS.WEB_LOGIN_SIGN_UP_LINK}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_ADMIN_TAB}
    Element Should Not Be Visible       ${LOCATORS.WEB_LOGIN_TITLE}
    Click Element                       ${LOCATORS.SIGN_UP_LOGIN_LINK}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_ADMIN_TAB}
    Element Should Be Visible           ${LOCATORS.WEB_LOGIN_TITLE}

    # closing Login and Sign Up modal
    Click Element                       ${LOCATORS.LOGIN_MODAL}
    Element Should Not Be Visible       ${LOCATORS.WEB_LOGIN_TITLE}
    Sleep   1s
    Click Element                       ${LOCATORS.PREVIEW_SIGNUP_BTN}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_ADMIN_TAB}
    Sleep   1s
    Click Element                       ${LOCATORS.LOGIN_MODAL}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_ADMIN_TAB}

Validation Signup And Subscription 2
    [Tags]      regression      subscription
    [Documentation]     Not Logged In: Login via popup and Subscribe
    #Get all data from csv file
    Get First Data From CSV     input   parent
    #navigate to fundtube
    Open Fundtube
    Create Parent User Account


    #With a user that is NOT logged in: select Watch a Video
    Open Fundtube
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    ${vide_name}=       Get Text        ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.PREVIEW_LOGIN_BTN}
    Element Should Be Visible           ${LOCATORS.WEB_LOGIN_TITLE}

    #Enter valid login credentials (standard user) and select Login
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'EMAIL')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

    Element Should Not Be Visible       ${LOCATORS.WEB_LOGIN_TITLE}

    #In the Subscription Donation (STEP 1) pop up:
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_1_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_MODAL_NEXT_BTN}
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_2_TITLE}

    #Enter (test) billing information and select the Submit Payment button
    Select From List By Value       ${LOCATORS.SUBSCR_CC_TYPE_SELECT}   $[csv:value(input,'CC_TYPE')]
    Input Text                      ${LOCATORS.SUBSCR_CC_NUM_FIELD}     $[csv:value(input,'CC_NUMBER')]
    Input Text                      ${LOCATORS.SUBSCR_CC_MONTH_FIELD}   $[csv:value(input,'CC_MONTH')]
    Input Text                      ${LOCATORS.SUBSCR_CC_YEAR_FIELD}    $[csv:value(input,'CC_YEAR')]
    Input Text                      ${LOCATORS.SUBSCR_CC_CVC_FIELD}     $[csv:value(input,'CC_CVC')]
    Input Text                      ${LOCATORS.SUBSCR_NAME_FIELD}       $[csv:value(input,'FIRSTNAME')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_1_FIELD}   $[csv:value(input,'STREET_1')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_2_FIELD}   $[csv:value(input,'STREET_2')]
    Input Text                      ${LOCATORS.SUBSCR_CITY_FIELD}       $[csv:value(input,'CITY')]
    Select From List By Value       ${LOCATORS.SUBSCR_STATE_SELECT}     $[csv:value(input,'STATE')]
    Input Text                      ${LOCATORS.SUBSCR_ZIPCODE_FIELD}    $[csv:value(input,'ZIPCODE')]
    Click Element                   ${LOCATORS.SUBSCR_SAVE_PAYMENT_CHECK}
    Click Element                   ${LOCATORS.SUBSCR_SUBMIT_PAYMENT_BTN}

    Sleep   2s
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_3_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_CONT_TO_VIEW_VIDEO}

    # User is taken to the page where the video is loaded
    Verify Text Is Present          ${vide_name}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}

    Click Element                   ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.VIDEO_IN_PLAY}
    Wait For Visible                ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}
    Sleep   2s

    # Delete user
    Logout To Fundtube
    Delete User By Email            $[csv:value(input,'EMAIL')]

Validation Signup And Subscription 3
    [Tags]      regression      subscription
    [Documentation]     Sign Up via popup :  Activate as Parent (user-entered info)
    #Get all data from csv file
    Get First Data From CSV     input   parent
    #navigate to fundtube
    Open Fundtube

    # Select a video that has a preview
    # Select the Sign Up button beneath the video
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    ${vide_name}=       Get Text        ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.PREVIEW_SIGNUP_BTN}
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
    # User is taken to the page with the originally selected video
    Activate User By Email      $[csv:value(input,'EMAIL')]     $[csv:value(input,'EMAIL_PASSWORD')]
    Verify Text Is Present      ${vide_name}

    #Login with information used to sign up (above)
    Click Element           ${LOCATORS.PREVIEW_LOGIN_BTN}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'EMAIL')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

    #In the Subscription Donation (STEP 1) pop up:
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_1_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_MODAL_NEXT_BTN}
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_2_TITLE}

    #Enter (test) billing information and select the Submit Payment button
    Select From List By Value       ${LOCATORS.SUBSCR_CC_TYPE_SELECT}   $[csv:value(input,'CC_TYPE')]
    Input Text                      ${LOCATORS.SUBSCR_CC_NUM_FIELD}     $[csv:value(input,'CC_NUMBER')]
    Input Text                      ${LOCATORS.SUBSCR_CC_MONTH_FIELD}   $[csv:value(input,'CC_MONTH')]
    Input Text                      ${LOCATORS.SUBSCR_CC_YEAR_FIELD}    $[csv:value(input,'CC_YEAR')]
    Input Text                      ${LOCATORS.SUBSCR_CC_CVC_FIELD}     $[csv:value(input,'CC_CVC')]
    Input Text                      ${LOCATORS.SUBSCR_NAME_FIELD}       $[csv:value(input,'FIRSTNAME')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_1_FIELD}   $[csv:value(input,'STREET_1')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_2_FIELD}   $[csv:value(input,'STREET_2')]
    Input Text                      ${LOCATORS.SUBSCR_CITY_FIELD}       $[csv:value(input,'CITY')]
    Select From List By Value       ${LOCATORS.SUBSCR_STATE_SELECT}     $[csv:value(input,'STATE')]
    Input Text                      ${LOCATORS.SUBSCR_ZIPCODE_FIELD}    $[csv:value(input,'ZIPCODE')]
    Click Element                   ${LOCATORS.SUBSCR_SAVE_PAYMENT_CHECK}
    Click Element                   ${LOCATORS.SUBSCR_SUBMIT_PAYMENT_BTN}

    Sleep   2s
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_3_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_CONT_TO_VIEW_VIDEO}

    # User is taken to the page where the video is loaded
    Verify Text Is Present          ${vide_name}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}

    Click Element                   ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.VIDEO_IN_PLAY}
    Wait For Visible                ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}
    Sleep   2s

    # Delete user
    Logout To Fundtube
    Delete User By Email            $[csv:value(input,'EMAIL')]

Validation Signup And Subscription 4
    [Tags]      regression      subscription
    [Documentation]     Sign Up via popup :  (triggered after preview video) - Activate as Parent (user-entered info)
    #Get all data from csv file
    Get First Data From CSV     input   parent
    #navigate to fundtube
    Open Fundtube

    # Select a video that has a preview
    # Select the See Preview button
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    ${vide_name}=       Get Text        ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}

    # When video finishes, Sign Up pop up appears on top of video screen
    Click Element                       ${LOCATORS.PREVIEW_SEE_PREV_BTN}
    Element Should Be Visible           ${LOCATORS.VIDEO_IN_PLAY}
    Wait For Visible                    ${LOCATORS.SIGN_UP_PARENT_TAB}
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
    # User is taken to the page with the originally selected video
    Activate User By Email      $[csv:value(input,'EMAIL')]     $[csv:value(input,'EMAIL_PASSWORD')]
    Verify Text Is Present      ${vide_name}

    #Login with information used to sign up (above)
    Click Element           ${LOCATORS.PREVIEW_LOGIN_BTN}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'EMAIL')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

    #In the Subscription Donation (STEP 1) pop up:
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_1_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_MODAL_NEXT_BTN}
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_2_TITLE}

    #Enter (test) billing information and select the Submit Payment button
    Select From List By Value       ${LOCATORS.SUBSCR_CC_TYPE_SELECT}   $[csv:value(input,'CC_TYPE')]
    Input Text                      ${LOCATORS.SUBSCR_CC_NUM_FIELD}     $[csv:value(input,'CC_NUMBER')]
    Input Text                      ${LOCATORS.SUBSCR_CC_MONTH_FIELD}   $[csv:value(input,'CC_MONTH')]
    Input Text                      ${LOCATORS.SUBSCR_CC_YEAR_FIELD}    $[csv:value(input,'CC_YEAR')]
    Input Text                      ${LOCATORS.SUBSCR_CC_CVC_FIELD}     $[csv:value(input,'CC_CVC')]
    Input Text                      ${LOCATORS.SUBSCR_NAME_FIELD}       $[csv:value(input,'FIRSTNAME')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_1_FIELD}   $[csv:value(input,'STREET_1')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_2_FIELD}   $[csv:value(input,'STREET_2')]
    Input Text                      ${LOCATORS.SUBSCR_CITY_FIELD}       $[csv:value(input,'CITY')]
    Select From List By Value       ${LOCATORS.SUBSCR_STATE_SELECT}     $[csv:value(input,'STATE')]
    Input Text                      ${LOCATORS.SUBSCR_ZIPCODE_FIELD}    $[csv:value(input,'ZIPCODE')]
    Click Element                   ${LOCATORS.SUBSCR_SAVE_PAYMENT_CHECK}
    Click Element                   ${LOCATORS.SUBSCR_SUBMIT_PAYMENT_BTN}

    Sleep   2s
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_3_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_CONT_TO_VIEW_VIDEO}

    # User is taken to the page where the video is loaded
    Verify Text Is Present          ${vide_name}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}

    Click Element                   ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.VIDEO_IN_PLAY}
    Wait For Visible                ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}
    Sleep   2s

    # Delete user
    Logout To Fundtube
    Delete User By Email            $[csv:value(input,'EMAIL')]

Validation Signup And Subscription 5
    [Tags]      regression      subscription2
    [Documentation]     Sign Up via popup :  Activate as School/Admin (user-entered info)
    #Get all data from csv file
    Get First Data From CSV     input   parent
    #navigate to fundtube
    Open Fundtube

    # Select a video that has a preview
    # Select the Sign Up button beneath the video
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    ${vide_name}=       Get Text        ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.PREVIEW_SIGNUP_BTN}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_ADMIN_TAB}
    Click Element                       ${LOCATORS.SIGN_UP_ADMIN_TAB}

    # Enter valid School Administrator Profile sign up information and select Join
    Input Text                  ${LOCATORS.SUBSCR_FIRSTNAME_ADMIN_FIELD}                $[csv:value(input,'FIRSTNAME')]
    Input Text                  ${LOCATORS.SUBSCR_LASTNAME_ADMIN_FIELD}                 $[csv:value(input,'LASTNAME')]
    Input Text                  ${LOCATORS.SUBSCR_TITLE_ADMIN_FIELD}                    $[csv:value(input,'TITLE')]
    Input Text                  ${LOCATORS.SUBSCR_EMAIL_ADMIN_FIELD}                    $[csv:value(input,'EMAIL')]
    Input Text                  ${LOCATORS.SUBSCR_SCHOOLNAME_ADMIN_FIELD}               $[csv:value(input,'SCHOOLNAME')]
    Input Text                  ${LOCATORS.SUBSCR_SCHOOL_ADD_ADMIN_FIELD}               $[csv:value(input,'SCHOOL_ADDRESS')]
    Select From List By Value   ${LOCATORS.SUBSCR_SCHOOL_STATE_ADMIN_SELECT}            $[csv:value(input,'SCHOOL_STATE')]
    Input Text                  ${LOCATORS.SUBSCR_PASSWORD_ADMIN_FIELD}                 $[csv:value(input,'PASSWORD')]
    Input Text                  ${LOCATORS.SUBSCR_CONFIRM_PASSWORD_ADMIN_FIELD}         $[csv:value(input,'PASSWORD')]
    Select From List By Value   ${LOCATORS.SUBSCR_DONATION_ADMIN_SELECT}                $[csv:value(input,'DONATION')]
    Click Element               ${LOCATORS.SUBSCR_SUBMIT_ADMIN_BTN}
    Sleep   2s
    Element Should Be Visible   ${LOCATORS.SIGN_UP_ADMIN_TY_MESSAGE}
    Click Element               ${LOCATORS.SIGN_UP_ADMIN_OK_BTN}
    Element Should Be Visible   ${LOCATORS.HOMEPAGE_MAIN_IMG}


    # Activation email:
    # User is taken to the page with the originally selected video
    Activate User By Email      $[csv:value(input,'EMAIL')]     $[csv:value(input,'EMAIL_PASSWORD')]
    #Verify Text Is Present      ${vide_name}

    #Login with information used to sign up (above)
    #Click Element           ${LOCATORS.PREVIEW_LOGIN_BTN}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'EMAIL')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

    #In the Subscription Donation (STEP 1) pop up:
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_1_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_MODAL_NEXT_BTN}
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_2_TITLE}

    #Enter (test) billing information and select the Submit Payment button
    Select From List By Value       ${LOCATORS.SUBSCR_CC_TYPE_SELECT}   $[csv:value(input,'CC_TYPE')]
    Input Text                      ${LOCATORS.SUBSCR_CC_NUM_FIELD}     $[csv:value(input,'CC_NUMBER')]
    Input Text                      ${LOCATORS.SUBSCR_CC_MONTH_FIELD}   $[csv:value(input,'CC_MONTH')]
    Input Text                      ${LOCATORS.SUBSCR_CC_YEAR_FIELD}    $[csv:value(input,'CC_YEAR')]
    Input Text                      ${LOCATORS.SUBSCR_CC_CVC_FIELD}     $[csv:value(input,'CC_CVC')]
    Input Text                      ${LOCATORS.SUBSCR_NAME_FIELD}       $[csv:value(input,'FIRSTNAME')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_1_FIELD}   $[csv:value(input,'STREET_1')]
    Input Text                      ${LOCATORS.SUBSCR_STREET_2_FIELD}   $[csv:value(input,'STREET_2')]
    Input Text                      ${LOCATORS.SUBSCR_CITY_FIELD}       $[csv:value(input,'CITY')]
    Select From List By Value       ${LOCATORS.SUBSCR_STATE_SELECT}     $[csv:value(input,'STATE')]
    Input Text                      ${LOCATORS.SUBSCR_ZIPCODE_FIELD}    $[csv:value(input,'ZIPCODE')]
    Click Element                   ${LOCATORS.SUBSCR_SAVE_PAYMENT_CHECK}
    Click Element                   ${LOCATORS.SUBSCR_SUBMIT_PAYMENT_BTN}

    Sleep   2s
    Element Should Be Visible       ${LOCATORS.SUBSCR_STEP_3_TITLE}
    Click Element                   ${LOCATORS.SUBSCR_CONT_TO_VIEW_VIDEO}

    # User is taken to the page where the video is loaded
    Verify Text Is Present          ${vide_name}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}

    Click Element                   ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.VIDEO_IN_PLAY}
    Wait For Visible                ${LOCATORS.PLAY_VIDEO_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_UPGRADE_BTN}
    Element Should Be Visible       ${LOCATORS.PREVIEW_DOWNLOAD_BTN}
    Sleep   2s

    # Delete user
    Logout To Fundtube
    Delete User By Email            $[csv:value(input,'EMAIL')]