*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SERVER}    localhost:7272
${BROWSER}    Chrome
${REGISTER URL}    http://${SERVER}/Lab4/Registration.html
${SUCCESS URL}    http://${SERVER}/Lab4/Success.html
${CHROME_BROWSER_PATH}    D:\\ChromeTesting\\chrome-win64\\chrome.exe
${CHROME_DRIVER_PATH}    D:\\ChromeTesting\\chromedriver-win64\\chromedriver.exe
${DELAY}    0
${VALID FIRSTNAME}    Somyod
${VALID LASTNAME}    Sodsai
${VALID ORGANIZATION}    CS KKU
${VALID EMAIL}    somyod@kkumail.com
${VALID PHONENUMBER}    091-001-1234

*** Test Cases ***
Open Form
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable       ${CHROME_BROWSER_PATH}
    ${service}   Evaluate   sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Open Browser    ${REGISTER URL}    ${BROWSER}
    Location Should Be    ${REGISTER URL}
    Capture Page Screenshot    filename=landingpage.png
    Set Selenium Speed    ${DELAY}

Register Success
    Input Text    firstname    ${VALID FIRSTNAME} 
    Input Text    lastname    ${VALID LASTNAME} 
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Wait Until Page Contains    Thank you for registering with us.
	Wait Until Page Contains    We will send a confirmation to your email soon.
	Location Should Contain    ${SUCCESS URL}
    Title Should Be    Success

Register Success No Organization Info
    Go To    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    organization    ${EMPTY}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Wait Until Page Contains    Thank you for registering with us.
	Wait Until Page Contains    We will send a confirmation to your email soon.
	Location Should Contain    ${SUCCESS URL}
    Title Should Be    Success

	[Teardown]    Close Browser