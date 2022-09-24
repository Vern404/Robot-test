*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']
${purchase_button}    //button[@id='dt_purchase_call_button']
${account_info_button}     //div[@id='dt_core_account-info_acc-info']
${real_account_tab}    //li[@id='real_account_tab']
${demo__account_tab}    //li[@id='dt_core_account-switcher_demo-tab']

*** Test Cases ***
Login To Deriv
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Set Selenium Speed    0.5
    Wait Until Page Contains Element    dt_purchase_call_button    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    vern.yi+3@besquare.com.my
    Input Text    //input[@type='password']    C0rrect_p4ssword
    Click Element    //button[@type='submit']
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Wait Until Page Contains Element     dt_purchase_call_button   30

Check Real and Demo Account
    Click Element    dt_core_account-info_acc-info
    Wait Until Page Contains Element    real_account_tab     30
    Wait Until Page Contains Element    dt_core_account-switcher_demo-tab     30
    # Move to demo account tab
    Click Element     dt_core_account-switcher_demo-tab
    Wait Until Page Contains Element    dt_core_account-switcher_demo-tab     30

Select Demo Account
    # Select demo account
    Wait Until Page Contains Element     //div[@id='dt_VRTC6739289']    30
    Click Element     //div[@id='dt_VRTC6739289']
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20

Check the Account Settings
    Page Should Contain Element    //*[@class='account-settings-toggle']
    Click Element    //*[@class='account-settings-toggle']
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20

Check the Security and safety
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Wait Until Page Contains Element    //*[@class='dc-vertical-tab__tab dc-vertical-tab__tab--floating']    30
    Page Should Contain Element    //*[@id='dt_Security and safety_link']

Check the Closing Account tab
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Page Should Contain Element    //*[@id='/account/closing-account']

Check Closing Account page
    Click Element    //*[@id='/account/closing-account']
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Wait Until Page Contains Element    //*[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']    20
    Page Should Contain Element    //*[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']

Check Close Account page
    Click Element    //*[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Wait Until Page Contains Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']    20

Close Account
    Click Element    //*[@name='financial-priorities']//parent::label
    Click Element    //*[@name='stop-trading']//parent::label
    Click Element    //*[@name='not-interested']//parent::label
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    #pop up the confirm modul
    Wait Until Page Contains Element    //*[@class='account-closure-warning-modal']
    Page Should Contain Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large' and contains(.,'Close account')]
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large' and contains(.,'Go Back')]

Close Account without select any reason
    Click Element    //*[@name='financial-priorities']//parent::label
    Click Element    //*[@name='stop-trading']//parent::label
    Click Element    //*[@name='not-interested']//parent::label
    Page Should Contain Element    //*[@disabled]
    Page Should Contain Element    //*[@class='dc-text closing-account-reasons__error']

Close Account with invalid Text
    Click Element    //*[@name='financial-priorities']//parent::label
    Input Text    //*[@name='do_to_improve']    ====
    Page Should Contain Element    //*[@disabled]
    Page Should Contain Element    //*[@class='dc-text closing-account-reasons__error']

    



    
