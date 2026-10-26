*** Settings ***
Library                QForce
Suite Setup            Open Browser                about:blank            chrome
Suite Teardown         CloseAllBrowsers

*** Variables ***
*** Test Cases ***
Home
    [Documentation]    Account creation
    [Tags]             Account
    GoTo               ${Login URL}                timeout=30
    VerifyText         Username
    TypeText           username                    ${username}
    ClickText          Log in
    VerifyText         Password
    TypeText           password                    ${password}
    ClickText          Log in
    ${MFA_needed}=     Run Keyword And Return Status                      Should Not Be Equal       ${None}    ${secret}

Log To Console              ${MFA_needed} # When given ${MFA_needed} is true, see Log to Console keyword result

IF                          ${MFA_needed}
    ${mfa_code}=       GetOTP                      ${username}            ${secret}
    TypeSecret         Verification Code           ${mfa_code}
    ClickText          Verify
    LaunchApp          Sales
    VerifyText         Accounts                    anchor=Contacts
    ClickText          Accounts                    anchor=Contacts
    VerifyText         New                         anchor=import
    ClickText          New
    UseModal           on
    TypeText           Account Name                CRT3
    PickList           Rating                      Warm
    PickList           Type                        Prospect
    PickList           Customer Priority           High
    PickList           Active                      Yes
    ClickText          Save
    UseModal           off
    VerifyText         Account CRT 3 created
    LaunchApp          Sales
    ClickText          Accounts                    anchor=Contacts
    VerifyText         CRT3                        anchor=Account Name 
    ClickText          CRT3
    ClickText          Details
    VerifyText         Account Owner               Nikhil TestingEnv
    VerifyText         Account Nmae                CRT3
    VerifyText         Rating                      Warm     
    VerifyText         Type                        Prospect
    VerifyText         Customer Priority           High
    VerifyText         Active                      Yes
    VerifyText         Type                        anchor=Phone 
    VerifyText         Phone                       anchor=Website
    VerifyText         Website                     anchor=Account Owner
    VerifyText         Account Owner               anchor=Account Site
    VerifyText         Account Site                anchor=Industry   




*** Keywords ***