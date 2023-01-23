*** Settings ***
Documentation   To validate the login form
Library     SeleniumLibrary
Test Setup      Open the browser with the Mortgage payment url
Test Teardown   Close Browser

*** Variables ***
${error_message_login}      css:.alert-danger
${error_message_content}     Incorrect username/password.


*** Test Cases ***
Validate unsuccessful login

    Fill the login form
    Wait until it checks and displays an error message
    Verify error message is correct

*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome  executable_path=C:/Users/cham.zein/Documents/chromedriver_win32/chromedriver.exe
    Go To    https://rahulshettyacademy.com/loginpagePractise/
    Maximize Browser Window

Fill the login form
    Input Text          id:username    rahulshettyacademy
    Input Password      id:password    12345678
    Click Button        signInBtn

Wait until it checks and displays an error message
    Wait Until Element Is Visible    css:.alert-danger

Verify error message is correct
    ${result}=  Get Text    css:.alert-danger
    Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${error_message_login}     ${error_message_content}



