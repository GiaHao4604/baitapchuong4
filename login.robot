*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}                   https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}               Chrome
${USERNAME_CORRECT}      Admin
${PASSWORD_CORRECT}      admin123
${USERNAME_WRONG}        giahao0406
${PASSWORD_WRONG}        giahao0406
${USER_FIELD}            xpath=//input[@name='username']
${PASS_FIELD}            xpath=//input[@name='password']
${LOGIN_BUTTON}          xpath=//button[@type='submit']
${DASHBOARD_TEXT}        Dashboard
${ERROR_MESSAGE}         Invalid credentials

*** Test Cases ***
Login With Valid Credentials
    Open Browser To Login Page
    Fill In Login Form    ${USERNAME_CORRECT}    ${PASSWORD_CORRECT}
    Submit Login Form
    Verify Successful Login
    Sleep    5s
    Close Browser

Login With Invalid Credentials
    Open Browser To Login Page
    Fill In Login Form    ${USERNAME_WRONG}    ${PASSWORD_WRONG}
    Submit Login Form
    Verify Login Failed
    Sleep    5s
    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${USER_FIELD}    timeout=10s

Fill In Login Form
    [Arguments]         ${username}    ${password}
    Input Text    ${USER_FIELD}    ${username}
    Input Text    ${PASS_FIELD}    ${password}

Submit Login Form
    Click Element    ${LOGIN_BUTTON}

Verify Successful Login
    Wait Until Location Contains    /dashboard    timeout=10s
    Wait Until Page Contains    ${DASHBOARD_TEXT}    timeout=10s

Verify Login Failed
    Wait Until Page Contains    ${ERROR_MESSAGE}    timeout=10s
