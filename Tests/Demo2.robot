*** Settings ***
Documentation   To validate the login form
Library     SeleniumLibrary
Library    Collections
Test Setup      Open the browser with the Mortgage payment url
Test Teardown   Close Browser session
Resource        Resource.robot

*** Variables ***
${error_login_locator}      css:.alert-danger
${error_message_content}    Incorrect username/password.
${shop_page_load}           css:.nav-link

*** Test Cases ***
Validate unsuccessful login
    Fill the login form     ${user_name}    ${invalid_password}
    Wait until element is located in the page   ${error_login_locator}
    Verify error message is correct

Validate cards display in the Shopping page
    Fill the login form     ${user_name}    ${valid_password}
    Wait until element is located in the page    ${shop_page_load}
    Verify card titles in the Shop page
    Select the card    Blackberry

Select the form and navigate to Child window
    Fill the login details and select the user option

*** Keywords ***
Fill the login form
    [Arguments]     ${username}     ${password}
    Input Text          id:username    ${username}
    Input Password      id:password    ${password}
    Click Button        signInBtn

Wait until element is located in the page
    [Arguments]     ${element}
    Wait Until Element Is Visible    ${element}

Verify error message is correct
#    ${result}=  Get Text    css:.alert-danger
#    Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${error_login_locator}     ${error_message_content}

Verify card titles in the Shop page
    @{expectedList} =   Create List     iphone X    Samsung Note 8      Nokia Edge      Blackberry
    ${cards_titles} =   Get WebElements    css:.card-title
    @{actualList} =     Create List

    FOR    ${element}    IN    @{cards_titles}
        Log    ${element.text}
        Append To List      ${actualList}   ${element.text}

    END
    Lists Should Be Equal    ${expectedList}    ${actualList}

Select the card
    [Arguments]     ${cardName}
    ${cards_titles} =   Get WebElements    css:.card-title
    ${index} =      Set Variable    1
    FOR    ${element}    IN    @{cards_titles}
            Exit For Loop If    '${cardName}' == '${element.text}'
            ${index} =  Evaluate   ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Fill the login details and select the user option
    Input Text        id:username    rahulshettyacademy
    Input Password    id:password    learning
    Click Element     css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body
    Click Element     id:okayBtn
    Click Element     id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms

