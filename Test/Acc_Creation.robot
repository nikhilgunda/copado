*** Settings ***
Library                QForce
Suite Setup            Open Browser                about:blank            chrome
Suite Teardown         CloseAllBrowsers

*** Variables ***
*** Test Cases ***
Home
    [Documentation]    Account creation
    [Tags]             Account
    GoTo               ${Login URL}    timeout=30
    VerifyText         Username
    TypeText           username                    ${Username}
    ClickText          Log in
    VerifyText         Password
    TypeText           password                    ${Password}
    ${MFA_needed}=     Run Keyword And Return Status                      Should Not Be Equal       ${None}    ${Secret}

Log To Console              ${MFA_needed} # When given ${MFA_needed} is true, see Log to Console keyword result

IF                          ${MFA_needed}
    ${mfa_code}=       GetOTP                      ${username}            ${Secret}
    TypeSecret         Verification Code           ${mfa_code}
    ClickText          Verify
    LaunchApp          sales
    VerifyText         Accounts                    anchor=contacts
    ClickText          Accounts                    anchor=contacts
    VerifyText         New                        anchor=import
    ClickText          New
    UseModal           on
    TypeText           Account name               CRT3
    PickList           rating                     warm
    PickList           type                       prospect
    PickList           customer priority          High
    PickList           Active                     yes
    ClickText          save     
    UseModal           off
    VerifyText         Account CRT 3 created
    




*** Keywords ***