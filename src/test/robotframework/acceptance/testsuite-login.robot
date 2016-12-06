*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot

Suite Setup     Set Field Mapping
Test Setup      Set Config And Test Data     web     $[config:test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Valid User Login
    [Tags]       fundtube    regression      demo
    [Documentation]     for demo purpose
    #Get all data from csv file
    Get First Data From CSV     input   valid

    Navigate To Form        $[config:url.dev.fundtube]
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'USERNAME')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}
    Verify Text Is Present  $[csv:value(input,'MESSAGE')]

Invalid User Login
    [Tags]       fundtube    regression      demo
    [Documentation]     for demo purpose
    #Get all data from csv file
    Get First Data From CSV     input   invalidemail

    Navigate To Form        $[config:url.dev.fundtube]
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'USERNAME')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}
    Verify Text Is Present  $[csv:value(input,'MESSAGE')]

Incorrect User Password Login
    [Tags]       fundtube    regression      demo
    [Documentation]     for demo purpose
    #Get all data from csv file
    Get First Data From CSV     input   incorrectpassword

    Navigate To Form        $[config:url.dev.fundtube]
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'USERNAME')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}
    Verify Text Is Present  $[csv:value(input,'MESSAGE')]

Blank Email And Password Login
    [Tags]       fundtube    regression      demo
    [Documentation]     for demo purpose
    #Get all data from csv file
    Get First Data From CSV     input   blank

    Navigate To Form        $[config:url.dev.fundtube]
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           $[csv:value(input,'USERNAME')]
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        $[csv:value(input,'PASSWORD')]
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}
    Verify Text Is Present  $[csv:value(input,'MESSAGE')]