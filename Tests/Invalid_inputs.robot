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
${VALID LASTNAME}    Sandee
${VALID ORGANIZATION}    CS KKU
${VALID EMAIL}    somyod@kkumail.com
${VALID PHONENUMBER}    091-111-1234

${INVALID PHONENO}    1234
${FIRSTNAME ERROR MESSAGE}    Please enter your first name!!
${LASTNAME ERROR MESSAGE}    Please enter your last name!!
${FULLNAME ERROR MESSAGE}    Please enter your name!!
${EMAIL ERROR MESSAGE}    Please enter your email!!
${PHONE ERROR MESSAGE}    Please enter your phone number!!
${INVALIDPHONE ERROR MESSAGE}    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)

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

Empty First Name
    Input Text    firstname    ${EMPTY}
    Input Text    lastname    ${VALID LASTNAME}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${FIRSTNAME ERROR MESSAGE}

Empty Last Name
    Go To    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${EMPTY}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${LASTNAME ERROR MESSAGE}

Empty First Name and Last Name
    Go To    ${REGISTER URL}
    Input Text    firstname    ${EMPTY}
	Input Text    lastname    ${EMPTY}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${FULLNAME ERROR MESSAGE}

Empty Email
    Go To    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${EMPTY}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${EMAIL ERROR MESSAGE}

Empty Phone Number
    Go To    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${EMPTY}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${PHONE ERROR MESSAGE}

Invalid Phone Number
    Go To    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    organization    ${VALID ORGANIZATION}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${INVALID PHONENO}
    Click Button    registerButton
    Location Should Contain    ${REGISTER URL}
	Wait Until Page Contains    ${INVALIDPHONE ERROR MESSAGE}

	[Teardown]    Close Browser
