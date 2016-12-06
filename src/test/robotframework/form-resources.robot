*** Settings ***
Library     JSpringBotGlobal
Library     String
Library     Collections

*** Variables ***
${POLL_MILLIS}      500
${TIMEOUT_MILLIS}    10000
${MAX_RESULT_DISPLAY}    250


*** Keywords ***
Open Frontend Url     [Arguments]    ${url}     ${username}      ${password}
    Navigate To Form        ${url}
    Click Element           ${LOCATORS.WEB_LOGIN_LINK}
    Input Text              ${LOCATORS.WEB_EMAIL_FIELD}           ${username}
    Input Text              ${LOCATORS.WEB_PASSWORD_FIELD}        ${password}
    Click Element           ${LOCATORS.WEB_LOGIN_BUTTON}

Type to Input Field     [Arguments]    ${loactor}     ${value}
    Click Element       ${loactor}
    Input Text          ${loactor}     ${value}