*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']
${purchase_button}    //button[@id='dt_purchase_call_button']
${account_info_button}     //div[@id='dt_core_account-info_acc-info']
${real_account_tab}    //li[@id='real_account_tab']
${demo__account_tab}    //li[@id='dt_core_account-switcher_demo-tab']
# ${real_account_no}    //div[@class='acc-switcher_loginid-text'and contains(.,'CR4457174')]

*** Test Cases ***
Login To Deriv
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    dt_purchase_call_button    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    test@example.com
    Input Text    //input[@type='password']    *********
    Click Element    //button[@type='submit']
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Wait Until Page Contains Element     dt_purchase_call_button   30
    # List Selection Should Be    //*[@id="dt_account_switcher_modal"]/div/div/div[1]/div[1]    //*[@id="real_account_tab"]

Check Real and Demo Account
    Click Element    dt_core_account-info_acc-info
    Wait Until Page Contains Element    real_account_tab     30
    # Wait Until Page Contains Element    real_account_no     30
    Wait Until Page Contains Element    dt_core_account-switcher_demo-tab     30
    # Move to demo account
    Click Element     dt_core_account-switcher_demo-tab
    Wait Until Page Contains Element    dt_core_account-switcher_demo-tab     30
    

Buy rise contract
    # Select demo account
    Wait Until Page Contains Element     //div[@id='dt_VRTC6739289']    30
    Click Element     //div[@id='dt_VRTC6739289']
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20

    # Select the asset
    Wait Until Page Contains Element    //div[@class='cq-menu-btn']    30
    Click Element    //div[@class='cq-menu-btn']
    Sleep    5
    Click Element    //*[contains(text(),'Synthetic')]
    # Select volatility 10(1s)
    Wait Until Page Contains Element    //div[@class='sc-mcd__item sc-mcd__item--1HZ10V ' and contains(.,'Volatility 10 (1s) Index')]    50
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--1HZ10V ' and contains(.,'Volatility 10 (1s) Index')] 
    # Select Contract Type:Rise
    Wait Until Page Contains Element     dt_purchase_call_button   30
    Click Element    //div[@class='contract-type-widget__display']
    Wait Until Page Contains Element    //div[@id='dt_contract_rise_fall_item']
    Click Element    //div[@id='dt_contract_rise_fall_item']
    # Select Tick
    Click Element    //button[@id='dc_t_toggle_item']
    # Buy rise
    Click Element    dt_purchase_call_button

Buy Lower Contract
    Wait Until Page Contains Element    //div[@class='cq-menu-btn']    30
    Click Element    //div[@class='cq-menu-btn']
    Sleep    5
    Click Element    //*[contains(text(), 'Forex')]
    # Select AUD/USD
    Wait Until Page Contains Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ' and contains(.,'AUD/USD')]    50
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ' and contains(.,'AUD/USD')]
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Click Element    //*[@class='contract-type-widget__display']
    Click Element    //*[@id='dt_contract_high_low_item']
    Click Element    //*[@class='dc-input__field']
    Press Keys    none    BACKSPACE+1
    # Payout
    Click Element    //button[@id='dc_payout_toggle_item']
    Click Element    //input[@id='dt_amount_input']
    Press Keys    none    BACKSPACE+5.50
    Sleep    2
    Click Element    //button[@id='dt_purchase_put_button']

Check relative barrier error
    # Select Forex 
    Wait Until Page Contains Element    //div[@class='cq-menu-btn']    30
    Click Element    //div[@class='cq-menu-btn']
    Sleep    5
    Click Element    //*[contains(text(), 'Forex')]
    # Select AUD/USD
    Wait Until Page Contains Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ' and contains(.,'AUD/USD')]    50
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ' and contains(.,'AUD/USD')]
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Click Element    //*[@class='contract-type-widget__display']
    Click Element    //*[@id='dt_contract_high_low_item']
    Click Element    //*[@class='dc-input__field']
    Press Keys    none    BACKSPACE+1
    # Barrier
    Press Keys    //div[@class='dc-input-field trade-container__barriers-single']    CTRL+A+BACKSPACE
    Input Text    dt_barrier_1_input    -0.11111
    Sleep    2
    Click Element    //button[@id='dt_purchase_put_button']

Check Multiplier Contract Parameter
    # Select Synthetic Indices
    Wait Until Page Contains Element    //div[@class='cq-menu-btn']    30
    Click Element    //div[@class='cq-menu-btn']
    Sleep    5
    Click Element    //*[contains(text(), 'Synthetic Indices')]
    # Select Volatility 50 Index
    Wait Until Page Contains Element    //div[@class='sc-mcd__item sc-mcd__item--R_50 ' and contains(.,'Volatility 50 Index')]    30
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--R_50 ' and contains(.,'Volatility 50 Index')] 
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    # Select Multiplier
    Click Element    //*[@class='contract-type-widget__display']
    Click Element    //*[@id='dt_contract_multiplier_item']
Check stake    
    # Check stake
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Page Should Contain    Stake
    Page Should Not Contain    Payout
Check deal cancellation
    # Only deal cancellation
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Wait Until Page Contains Element    //*[@class='dc-checkbox']
    Click Element    //*[@class='dc-checkbox']
    Checkbox Should Be Selected    //*[@class='dc-checkbox']
    Checkbox Should Not Be Selected  //*[@class='dc-checkbox take_profit-checkbox__input']
    Checkbox Should Not Be Selected    //*[@id='dc_stop_loss-checkbox_input']
Check take profit and stop loss
    # Only take profit and stop loss
    Wait Until Page Does Not Contain Element    //*[@aria-label="Loading interface..."]    20
    Wait Until Page Contains Element      //*[@class='dc-checkbox stop_loss-checkbox__input']
    Click Element  //*[@class='dc-checkbox stop_loss-checkbox__input']
    Checkbox Should Be Selected    //*[@class='dc-checkbox stop_loss-checkbox__input']
    Click Element    //*[@class='dc-checkbox take_profit-checkbox__input']
    Checkbox Should Be Selected    //*[@class='dc-checkbox take_profit-checkbox__input']]
    Checkbox Should Not Be Selected    //*[@class='dc-checkbox']

    