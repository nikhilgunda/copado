*** Settings ***
Library           QForce
Suite Setup       Open Browser        about:blank    chrome
Suite Teardown    CloseAllBrowsers
*** Variables ***
*** Test Cases ***
Home
    [Documentation]    Account creation
    [Tags]             Account
    GoTo               Login url
    
*** Keywords ***