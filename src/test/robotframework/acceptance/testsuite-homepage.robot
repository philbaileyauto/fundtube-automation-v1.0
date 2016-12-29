*** Settings ***
Resource    ../selenium-resources.robot
Resource    ../form-resources.robot


Suite Setup     Set Config And Test Data    web     $[config:test.data]
Test Teardown   Test Tear Down


*** Test Cases ***
Validation Homepage - Not Logged In
    [Tags]      regression      validation      homepage
    [Documentation]   validate homepage Not Logged In
    #navigate to fundtube and validate page title
    Open Fundtube
    Title Should Be                 ${LOCATORS.HOMEPAGE_TITLE}

    # Verify Log In link and pop-up
    Element Should Be Visible       ${LOCATORS.WEB_LOGIN_LINK}
    Click Element                   ${LOCATORS.WEB_LOGIN_LINK}
    Element Should Be Visible       ${LOCATORS.WEB_LOGIN_TITLE}
    Click Element                   ${LOCATORS.LOGIN_MODAL}
    Element Should Not Be Visible   ${LOCATORS.WEB_LOGIN_TITLE}

    # Verify Social Media links
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_FACEBOOK_TOP_LOGO}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_TWITTER_TOP_LOGO}

    # Verify Logo element (Upper Left)
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_FUNDTUBE_LOGO}

    # Select How it Works
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_HOWITWORK_FT_OVERVIEW}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_HOWITWORK_EXP_VIDEO}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_HOWITWORK_WHY_FT}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_HOWITWORK_FAQS}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_HOWITWORK_HELP}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Element Should Not Be Visible   ${LOCATORS.HOMEPAGE_HOWITWORK_EXP_VIDEO}
    # Select How it Works -> FundTube Overview
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_FT_OVERVIEW}
    Page Location Should Be         ${LOCATORS.FT_OVERVIEW_URL}
    Go Back
    # Select How it Works -> Explanation Video
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_EXP_VIDEO}
    Element Should Be Visible       ${LOCATORS.EXP_VIDEO_MODAL}
    Click Element                   ${LOCATORS.EXP_VIDEO_CLOSE}
    Element Should Not Be Visible   ${LOCATORS.EXP_VIDEO_MODAL}
    # Select How it Works ->  Why use Fundtube
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_WHY_FT}
    Page Location Should Be         ${LOCATORS.WHY_FT_URL}
    Go Back
    # Select How it Works -> FAQs
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_FAQS}
    Page Location Should Be         ${LOCATORS.FAQS_URL}
    Go Back
    # Select How it Works -> Help
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_HOWITWORK_HELP}
    Page Location Should Be         ${LOCATORS.HELP_URL}
    Go Back

    # Validate Get Started menu contents
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_GETSTARTED_SCHOOL_SETUP}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_GETSTARTED_DONOR_SETUP}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_GETSTARTED_UPLOAD_VIDEO}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_GETSTARTED_WATCH_VIDEO}
    Element Should Be Visible       ${LOCATORS.HOMEPAGE_GETSTARTED_SPREAD_WORD}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Element Should Not Be Visible   ${LOCATORS.HOMEPAGE_GETSTARTED_SCHOOL_SETUP}
    # Select Get Started -> School set-up
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_SCHOOL_SETUP}
    Page Location Should Be         ${LOCATORS.SCHOOL_SETUP_URL}
    Go Back
    # Select Get Started -> Parent/Donor set-up
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_DONOR_SETUP}
    Page Location Should Be         ${LOCATORS.DONOR_SETUP_URL}
    Go Back
    # Select Get Started -> Upload videos
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_UPLOAD_VIDEO}
    Page Location Should Be         ${LOCATORS.UPLOAD_VIDEO_URL}
    Go Back
    # Select Get Started -> Watch videos
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_WATCH_VIDEO}
    Page Location Should Be         ${LOCATORS.WATCH_VIDEO_URL}
    Go Back
    # Select Get Started -> Spread the word
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_LINK}
    Click Element                   ${LOCATORS.HOMEPAGE_GETSTARTED_SPREAD_WORD}
    Page Location Should Be         ${LOCATORS.SPREAD_WORD_URL}
    Go Back

    # Verify Sign Up button
    Click Element                       ${LOCATORS.HOMEPAGE_SIGNUP_LINK}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Be Visible           ${LOCATORS.SIGN_UP_ADMIN_TAB}
    Sleep   1s
    Click Element                       ${LOCATORS.LOGIN_MODAL}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_PARENT_TAB}
    Element Should Not Be Visible       ${LOCATORS.SIGN_UP_ADMIN_TAB}

    # validate images and links
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_MAIN_IMG}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_UPLOAD_VIDEO_IMG}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_WATCH_VIDEO_IMG}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_SPREAD_WORD_IMG}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_ABOUT_TITLE}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_ABOUT_US_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_NEWSROOM_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_COPPA_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_TERMS_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_PRIVACY_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_CONTACT_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_LEGAL_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_FUND_INFO_TITLE}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_HELP_TITLE}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_TIPS_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_SAFETY}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_VIDEO_RELEASE_LINK}

    Element Should Be Visible           ${LOCATORS.HOMEPAGE_SUBSC_MAILLIST_TITLE}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_EMAIL_FIELD}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_SUBSCRIBE_BTN}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_FOOTER_MESSAGE}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_FOOTER_PRIVACT_LNIK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_FOOTER_TERMS_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_BACK_TO_TOP_LINK}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_FACEBOOK_FOOTER_LOGO}
    Element Should Be Visible           ${LOCATORS.HOMEPAGE_TWITTER_FOOTER_LOGO}
    Click Element                       ${LOCATORS.HOMEPAGE_BACK_TO_TOP_LINK}