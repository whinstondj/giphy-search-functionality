*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${scheme}           https
${homepage}         giphy.com
${browser}          gc
${termToSearch}     bottle
${searchIconCss}    css=#searchbar > div > a > div > div.search-button__SearchIcon-cXFmJV.fPODsT > img
${firstItemCss}     css=#gif-results > div:nth-child(4) > div._3Rk-bEWGMEWneVsv7_KwZS > div > div:nth-child(2) > div:nth-child(1) > div > a > img
${copyLinkCss}      css=#gif-results > div:nth-child(4) > div > div._3lHuNOPnvckvR4CcUUV0gB > div._3GqNJoK78iEyK73CecBC8p > div._3QdblofxPqtzAdaMHVvGnV > div._14glt1AeSjnOdEg6jPXf4y > div:nth-child(2) > span
${linkToShorten}    css=#gif-results > div:nth-child(4) > div > div._3lHuNOPnvckvR4CcUUV0gB > div._3GqNJoK78iEyK73CecBC8p > div.Z49nRFfT4LBxinbLNRSZl > div > div > div:nth-child(2) > div:nth-child(2) > input[type="text"]
${shortenFieldCss}     css=#gif-results > div:nth-child(4) > div > div._3lHuNOPnvckvR4CcUUV0gB > div._3GqNJoK78iEyK73CecBC8p > div.Z49nRFfT4LBxinbLNRSZl > div > div > div:nth-child(2) > div:nth-child(4) > div._2SAYzj8-J4IFkk--EfzPMz > input[type="text"]
${shortenButtonCss}     css=#gif-results > div:nth-child(4) > div > div._3lHuNOPnvckvR4CcUUV0gB > div._3GqNJoK78iEyK73CecBC8p > div.Z49nRFfT4LBxinbLNRSZl > div > div > div:nth-child(2) > div:nth-child(4) > div._2SAYzj8-J4IFkk--EfzPMz > div

*** Keywords ***
Open the homepage
    Set Screenshot Directory    screenshot
    Open Browser        ${scheme}://${homepage}     ${browser}

*** Test Cases ***
C001 Search for an image on Giphy
    Open the homepage
    Input Text      search-box      ${termToSearch}
    Click Element       ${searchIconCss}
    Wait Until Element Is Visible       ${firstItemCss}
    Click Element       ${firstItemCss}
    Wait Until Element Is Visible       ${copyLinkCss}
    Click Element           ${copyLinkCss}
    Wait Until Element Is Visible       ${linkToShorten}
    ${textToGetShorten}=       Get Value       ${linkToShorten}
    Log To Console      ${textToGetShorten}
    Input Text      ${shortenFieldCss}      ${textToGetShorten}
    Click Element   ${shortenButtonCss}
    Wait Until Keyword Succeeds     1 min   5 sec   Element Should Contain      ${shortenButtonCss}        Booyah!
    Close Browser
