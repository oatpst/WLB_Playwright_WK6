*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Test Cases ***

การค้นหาร้านอาหารด้วยการใช้ Keywords และตรวจสอบ URL

    Open Browser    url=https://www.google.com    browser=chrome
    Input Text    name=q    text=ร้านอาหารญี่ปุ่นใกล้ฉัน
    Press Keys    name=q    RETURN
    Element Text Should Be    name=q    text=ร้านอาหารญี่ปุ่นใกล้ฉัน
    Page Should Contain    เท็นชิโนะ
    Page Should Contain Link    [TBD]

*** Keywords ***