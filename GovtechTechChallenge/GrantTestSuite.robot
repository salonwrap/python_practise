*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}  https://public:Let$BeC001@bgp-qa.gds-gov.tech
${failEligibility}  The applicant may not meet the eligibility criteri
*** Test Cases ***
LoginTest
    #create webdriver chrome
    Open Browser    ${url}
    #Set Selenium Speed  2
    sleep   5
    #Wait Until Element Is Visible   xpath://div[@class='bgp-btn bgp-btn-loginCorpPass margin-top-sm margin-btm-md'] [timeout]  5
    Click Element   xpath://div[@class='bgp-btn bgp-btn-loginCorpPass margin-top-sm margin-btm-md']
    Input Text  name:CPUID      S1234567A
    Input Text  name:CPUID_FullName     Tan Ah Kow
    Input Text  name:CPEntID        BGPQEDEMO

GrantDraft
    LoginToGrantApplication

UserStory1-AC1.1
    set selenium implicit wait      3 seconds
    Page Should Contain Radio Button        react-eligibility-sg_registered_check
    Select Radio Button     react-eligibility-sg_registered_check   true
    Page Should Not Contain     ${failEligibility}
    select radio button     react-eligibility-sg_registered_check   false
    Page Should Contain     ${failEligibility}
    #reset to clear eligibility warning
    Select Radio Button     react-eligibility-sg_registered_check   true
UserStory1-AC1.2
    Page Should Contain Radio Button        react-eligibility-turnover_check
    Select Radio Button     react-eligibility-turnover_check    true
    Page Should Not Contain     ${failEligibility}
    Select Radio Button     react-eligibility-turnover_check    false
    Page Should Contain     ${failEligibility}
    #reset to clear eligibility warning
    Select Radio Button     react-eligibility-turnover_check    true
UserStory1-AC1.3
    Page Should Contain Radio Button        react-eligibility-global_hq_check
    Select Radio Button     react-eligibility-global_hq_check   true
    Page Should Not Contain     ${failEligibility}
    Select Radio Button     react-eligibility-global_hq_check   false
    Page Should Contain     ${failEligibility}
    #reset to clear eligibility warning
    Select Radio Button     react-eligibility-global_hq_check   true

UserStory1-AC1.4
    #checking if this is new target market
    Page Should Contain Radio Button        react-eligibility-new_target_market_check
    Select Radio Button     react-eligibility-new_target_market_check   true
    Page Should Not Contain     ${failEligibility}
    Select Radio Button     react-eligibility-new_target_market_check   false
    Page Should Contain     ${failEligibility}
    #reset to clear eligibility warning
    Select Radio Button     react-eligibility-new_target_market_check   true

UserStory1-AC1.5
    # checking if following statements are true
    Page Should Contain     The applicant has not started work on this project
    Page Should Contain     The applicant has not made any payment to any supp
    Page Should Contain     The applicant has not signed any contractual agree
    Page Should Contain Radio Button    react-eligibility-started_project_check
    Select Radio Button     react-eligibility-started_project_check     true
    Page Should Not Contain     ${failEligibility}
    Select Radio Button     react-eligibility-started_project_check     false
    Page Should Contain     ${failEligibility}
    #reset to clear eligibility warning
    Select Radio Button     react-eligibility-started_project_check     true

UserStory1-AC1.6
    Click Element       xpath://button[@id='save-btn']
    sleep   2
    Reload Page
    sleep       2
    Click Element       xpath://button[@id='next-btn']
    #sleep       10

UserStory2-ContactDetails
    #Run Keyword And Continue On Failure     Fail
    wait until page contains        Main Contact Person
    Page Should Contain     Main Contact Person

UserStory2.1-ContactDetailsChecks
    ${NameBox}   set variable        id=react-contact_info-name
    ${JobTitle}  set variable        id=react-contact_info-designation
    ${ContactNo}  set variable       id=react-contact_info-phone
    ${Email}  set variable            id=react-contact_info-primary_email
    ${AltContactPersonEmail}  set variable        id=react-contact_info-secondary_email
    ${MailingAddress}          set variable         id=react-contact_info-correspondence_address-postal

    element should be visible       ${NameBox}
    element should be enabled       ${NameBox}
    element should be visible       ${JobTitle}
    element should be enabled       ${JobTitle}
    element should be visible       ${ContactNo}
    element should be enabled       ${ContactNo}
    element should be visible       ${Email}
    element should be enabled       ${Email}
    element should be visible       ${AltContactPersonEmail}
    element should be enabled       ${AltContactPersonEmail}
    element should be visible       ${MailingAddress}
    element should be enabled       ${MailingAddress}


    #steps to check for warning message
    sleep       2
    input text      ${NameBox}        Tan Ah Kow
    sleep       2
    input text      ${JobTitle}        Software Engineer
    #clear element text      ${NameBox}
    sleep       2
    input text      ${ContactNo}    1234567
    clear element text      ${NameBox}
    sleep   2
    set selenium implicit wait      10 seconds
    element should be visible       id=react-contact_info-phone-alert
    #Check1 for 8 digit validation in contact
    input text      ${NameBox}        Tan Ah Kow
    input text      ${ContactNo}    12345678

    #Check2 for 8 digit validation once corrected
    element should not be visible       id=react-contact_info-phone-alert

    #check3 for valid email entry
    input text      ${Email}    wrong
    Mouse Out       ${Email}
    element should be visible       id=react-contact_info-primary_email-alert
    clear element text      ${Email}

    #check3 for valid email entry
    input text      ${Email}    tan@gmail.com
    Mouse Out       ${Email}
    element should not be visible   id=react-contact_info-primary_email-alert

    #check4.1 for invalid1 altemail entry
    input text      ${AltContactPersonEmail}    tan@gmail.com
    Mouse Out       ${AltContactPersonEmail}
    sleep   2
    element should be visible       id=react-contact_info-secondary_email-alert
    clear element text  ${AltContactPersonEmail}

    #check4.2 for invalid2 altemail entry
    input text      ${AltContactPersonEmail}    tan123
    Mouse Out       ${AltContactPersonEmail}
    sleep   2
    element should be visible       id=react-contact_info-secondary_email-alert
    Page Should Contain     Oops, that doesn't seem like a valid email address
    clear element text  ${AltContactPersonEmail}


    #check4.3 for valid alt email entry
    input text      ${AltContactPersonEmail}    ban@gmail.com
    Mouse Out       ${AltContactPersonEmail}
    element should not be visible       id=react-contact_info-secondary_email-alert


    #check4.4 for invalid  non-singapore postal code

    input text  ${MailingAddress}       1212
    Mouse Out   ${MailingAddress}
    sleep   2
    element should be visible       id=react-contact_info-correspondence_address-postal-alert
    Page Should Contain     Oops, that’s not a 6-digit Singapore postal code

    #check4.5 for invalid  not found postal code
    clear element text  ${MailingAddress}
    input text  ${MailingAddress}       609091
    Mouse Out   ${MailingAddress}
    sleep   2
    element should be visible       id=react-contact_info-correspondence_address-postal-alert
    Page Should Contain     We can't find the postal code. Please try again.

    #check4.1 for valid Singapore Postal code
    clear element text  ${MailingAddress}
    input text  ${MailingAddress}       640755
    clear element text  ${MailingAddress}
    input text  ${MailingAddress}       640755
    Mouse Out   ${MailingAddress}
    sleep   2
    element should not be visible       id=react-contact_info-correspondence_address-postal-alert
    ${BlkValue}=    Get Value       id=react-contact_info-correspondence_address-block
    ${StreetAdd}=   Get Value       id=react-contact_info-correspondence_address-street
    log to console      ${BlkValue} #= 755
    log to console      ${StreetAdd} #=JURONG WEST STREET 74
    Page Should Contain     Mailing Address
UserStory2_AC3
    Select Checkbox     id=react-contact_info-correspondence_address-copied

UserStory2_AC4
    #The page also contains a ‘Letter of Offer Addressee’ subsection with the following inputs:
    Page Should Contain     Letter Of Offer Addressee

    element should be visible       id=react-contact_info-offeree_name-label
    element should be enabled       id=react-contact_info-offeree_name-label
    element should be visible       id=react-contact_info-offeree_designation
    element should be enabled       id=react-contact_info-offeree_designation
    element should be visible       id=react-contact_info-offeree_email
    element should be enabled       id=react-contact_info-offeree_email


UserStory2_AC5
    #There should be an option ‘ Same as main contact person’ which will populate the subsection
    Select Checkbox         id=react-contact_info-copied

UserStory2_AC6
    #Clicking Save will save the application
    Click Element       xpath://button[@id='save-btn']
    sleep   2
    Reload Page
    sleep       2
    #Click Element       xpath://button[@id='next-btn']

UserStory3_AC1
    Click Element       xpath://span[contains(text(),'Declare & Review')]
    sleep   2
    Page Should Contain Element     xpath://h2[contains(text(),'Declare & Acknowledge Terms')]
#1.Criminal Liability
    Select Radio Button     react-declaration-criminal_liability_check      true
    element should be visible       id=react-declaration-criminal_liability_remarks
    Select Radio Button     react-declaration-criminal_liability_check      false
    element should not be visible       id=react-declaration-criminal_liability_remarks
#2.Civil Suit
    Select Radio Button     react-declaration-civil_proceeding_check    false
    Select Radio Button     react-declaration-civil_proceeding_check    true
    element should be visible       id=react-declaration-civil_proceeding_remarks
    input text      id=react-declaration-civil_proceeding_remarks   Yes I have but it's seen cleared
#3.Insolvency declaration
    Select Radio Button     react-declaration-insolvency_proceeding_check   true
    element should be visible   id=react-declaration-insolvency_proceeding_remarks
    Select Radio Button     react-declaration-insolvency_proceeding_check   false
    element should not be visible   id=react-declaration-insolvency_proceeding_remarks
#4.Project Incentives
    Select Radio Button     react-declaration-project_incentives_check      true
    element should be visible       react-declaration-project_incentives-0-name
    Select Radio Button     react-declaration-project_incentives_check      false
    element should not be visible       react-declaration-project_incentives-0-name

#5.Incentive check
    Select Radio Button     react-declaration-other_incentives_check        true
    element should be visible       react-declaration-other_incentives-0-name
    Select Radio Button     react-declaration-other_incentives_check        false
    element should not be visible       react-declaration-other_incentives-0-name

#6.Project Declare check
    Select Radio Button     react-declaration-project_commence_check        true
    element should be visible   react-declaration-project_commence_remarks
    Select Radio Button     react-declaration-project_commence_check        false
    element should not be visible   react-declaration-project_commence_remarks

#7.Declaration related party
    Select Radio Button     react-declaration-related_party_check       true
    element should be visible   react-declaration-related_party_remarks
    Select Radio Button     react-declaration-related_party_check       false
    element should not be visible   react-declaration-related_party_remarks

#8.Declaration declaration-covid
    Select Radio Button     react-declaration-covid_safe_check      false
    Page Should Contain Element     xpath://h1[contains(text(),'You must comply with all applicable SDMs to be eli')]
    Select Radio Button     react-declaration-covid_safe_check      true
    Page Should Not Contain Element     xpath://h1[contains(text(),'You must comply with all applicable SDMs to be eli')]

#9.Covid Safe Queues
    Select Radio Button        react-declaration-covid_safe_ques_check  false
    Page Should Contain Element     xpath://h1[contains(text(),'You must comply with all applicable SDMs to be eli')]
    Select Radio Button        react-declaration-covid_safe_ques_check  true
    Page Should Not Contain Element     xpath://h1[contains(text(),'You must comply with all applicable SDMs to be eli')]

#Review
    Click Element        xpath://button[@id='review-btn']
    sleep   5

#UserStory3_AC2_missingInputs


*** Keywords ***

LoginToGrantApplication
    #Set Selenium Speed  4
    Click Element   xpath://form[2]//button[1]
    sleep       5
    Click Element   xpath://h4[contains(text(),'Get new grant')]
    sleep       5
    CLick Element   xpath://div[contains(text(),'IT')]
    sleep       5
    Click Element   xpath://div[contains(text(),'Bring my business overseas or establish a stronger')]
    sleep       5
    Click Element   xpath://span[contains(text(),'Set up an overseas market, identify overseas busin')]
    #sleep       5
    Wait Until Element Is Visible   xpath://button[@id='go-to-grant']   10 seconds
    Click Element   xpath://button[@id='go-to-grant']
    #Wait Until Element Is Visible   xpath://button[@id='keyPage-form-button']   [timeout]  5
    sleep       8
    Click Element   xpath://button[@id='keyPage-form-button']
    sleep       5
