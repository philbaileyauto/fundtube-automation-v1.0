*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Field Mapping
Test Setup      Set Config And Test Data     web     $[config:test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Validation Signup And Subscription 1
    [Tags]      regression      validation
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
    [Tags]      regression      validation
    [Documentation]     Not Logged In: Login via popup and Subscribe
    #navigate to fundtube
    Open Fundtube

    #navigate between Login
    Click Element                       ${LOCATORS.HOME_WATCH_VIDEO_IMG}
    Click Element                       ${LOCATORS.WATCH_FIRST_INDEX_VIDEO_LINK}
    Click Element                       ${LOCATORS.PREVIEW_LOGIN_BTN}
    Element Should Be Visible           ${LOCATORS.WEB_LOGIN_TITLE}

    #login
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[config:default.username]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[config:default.password]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

    Element Should Not Be Visible       ${LOCATORS.WEB_LOGIN_TITLE}
    Verify Text Is Present              $[config:default.message]