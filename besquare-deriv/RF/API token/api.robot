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

Check the API token tab
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Page Should Contain Element    //*[@id='/account/api-token']

Check API token page
    Click Element    //*[@id='/account/api-token']
    Wait Until Page Does Not Contain Element    //*[@data-testid='dt_initial loader']    20
    Wait Until Page Contains Element    //*[@class='da-api-token__checkbox-wrapper']    20
    Page Should Contain Element    //*[@class='da-api-token__checkbox-wrapper']

Create API token without select any scope
    Input Text    //*[@class='dc-input__field']    test
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes without token name
    Click Element    //*[@name='read']//parent::label
    Click Element    //*[@name='payments']//parent::label
    Click Element    //*[@name='admin']//parent::label
    Click Element    //*[@name='trade']//parent::label
    Click Element    //*[@name='trading_information']//parent::label
    Element Should Be Visible    //*[@name='read']//parent::label//ancestor::div[@class='composite-checkbox api-token__checkbox composite-checkbox--active']
    Element Should Be Visible    //*[@name='payments']//parent::label//ancestor::div[@class='composite-checkbox api-token__checkbox composite-checkbox--active']
    Element Should Be Visible    //*[@name='admin']//parent::label//ancestor::div[@class='composite-checkbox api-token__checkbox composite-checkbox--active']
    Element Should Be Visible    //*[@name='trade']//parent::label//ancestor::div[@class='composite-checkbox api-token__checkbox composite-checkbox--active']
    Element Should Be Visible    //*[@name='trading_information']//ancestor::div[@class='composite-checkbox api-token__checkbox composite-checkbox--active']
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes with one number
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Input Text    //*[@class='dc-input__field']    1
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes with one letter
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Input Text    //*[@class='dc-input__field']    a
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes with > 32 characters
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Input Text    //*[@class='dc-input__field']    123456789012345678901234567890123
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes with special character
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Input Text    //*[@class='dc-input__field']    1234=
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

Create API token by select all scopes with valid token name
    Press Keys     //*[@class='dc-input__field']    CTRL+A+BACKSPACE
    Input Text    //*[@class='dc-input__field']    test2
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

# Check API token with token list
    

# Create API token by select Read, Trading and Payment 
#     Click Element    //*[@name='read']//parent::label
#     Click Element    //*[@name='payments']//parent::label
#     Click Element    //*[@name='trading_information']//parent::label
#     Checkbox Should Be Selected    //*[@name='read']//parent::label
#     Checkbox Should Be Selected   //*[@name='payments']//parent::label
#     Checkbox Should Be Selected    //*[@name='trading_information']//parent::label
#     Input Text    //*[@class='dc-input__field']    test combo
#     Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']


Copy API token
    Click Element    //*[@data-testid='dt_copy_token_icon']
    Page Should Contain Element    //*[@class='dc-clipboard__popover dc-popover__bubble']
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']
    Page Should Contain Element    //*[@class='dc-clipboard__popover dc-popover__bubble']

Delete API token
    Click Element    //*[@data-testid="dt_token_delete_icon"]
    Page Should Contain Element    //*[@class='dc-modal-body']
    Click Element    //*[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']



