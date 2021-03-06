*** Settings ***
Documentation     Landing Page Logic
Library     SeleniumLibrary
Library     Collections
Resource    ../Test Data/Locators.robot
Resource    ../FrontOfficeApp.robot

*** Keywords ***
The "Condos.ca" page should load
    PRESS KEYS                          ${Condos.caDisplay}            TAB
    Sleep                               10s

The "Property.ca" page should load
    Click Element    xpath=//div[contains(@class,'TopMenu')]/ul/li/a[text()='property.ca']    
    #Switch to the Active window
    Switch Window       NEW     timeout=10

    PRESS KEYS                          ${Condos.caDisplay}            TAB
    Sleep                               10s

    # Wait Until "Property.ca" page loads
    # Wait Until Page Contains Element    xpath=//div[contains(@class,'TopMenu')]/ul/li/a[text()='property.ca']
    
The Search Box should be enabled on the Landing Page and User should be able to search the properties
    [Arguments]     ${City}

    # Wait Until Search Box is Enabled
    Wait Until Element Is Enabled       ${SearchTextBox}           timeout=20

    # Verify If Search Box is Enabled or Disabled
    ${SearchBoxStatus}=     Run Keyword And Return Status    Element Should be Enabled    ${SearchTextBox}

    IF  ${SearchBoxStatus} == True
         # Log To Console    Search Box Is Enabled
         Click Element    ${SearchTextBox}
         Input Text        ${SearchTextBox}         ${City}

         # Wait Until Toronto shows up and click on it
         Wait Until Page Contains Element    ${Selection_Option}     timeout=5
         Click Element                       ${Selection_Option}
    ELSE
        # Log To Console    Search Box Is Not Enabled. Exiting The Test
        Fail    Search Box Is Not Enabled
        Close Browser
    END
