*** Settings ***
Documentation   To validate the login form
...             Another line with 3 previous dots to indicate a comment
Library     SeleniumLibrary


*** Variables ***
${user_name}            rahulshettyacademy
${invalid_password}     12345678
${valid_password}       learning
${url}                  https://rahulshettyacademy.com/loginpagePractise/

*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome  executable_path=C:/Users/cham.zein/Documents/chromedriver_win32/chromedriver.exe
    Go To    ${url}
    Maximize Browser Window

Close Browser session
    Close Browser
