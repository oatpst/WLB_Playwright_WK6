*** Settings ***

Library    SeleniumLibrary
Test Teardown    Reset App State

*** Variables ***

${URL}    http://sck-dojo.ddns.net:8000/product/list
${BROWSER}    chrome

*** Test Cases ***
หน้า Product lists

    Open Browser    url=${URL}    browser=${BROWSER}
    Input Text    id=search-product-input    text=Balance Training Bicycle
    Press Keys    id=search-product-input    RETURN
    Wait Until Element Contains    id=product-card-name-1    Balance Training Bicycle
	Page Should Contain    text=4,314.60
    Click Element    id=product-card-name-1

หน้า Product Detail

    Page Should Contain    Balance Training Bicycle
    Page Should Contain    SportsFun
    Page Should Contain    4,314.60
    Page Should Contain    43 Points
    Page Should Contain Image    id=product-detail-image
    Click Button    id=product-detail-add-to-cart-btn
    Element Should Contain    id=header-menu-cart-badge    0

หน้า Shopping Cart

    Click Button    id=header-menu-cart-btn
    Page Should Contain    Shopping cart
    Page Should Contain    Balance Training Bicycle
    Wait Until Element Contains    id=product-1-price    4,314.60
    Page Should Contain    43 Points
    Element Should Contain    id=shopping-cart-subtotal-price    4,314.60
    Click Element    id=shopping-cart-checkout-btn

# หน้า Checkout

#     Element Should Contain    id=product-1-price    4,314.60
#     Element Should Contain    id=product-1-point    43 Points
#     Input Text    id=shipping-form-first-name-input    text=พิสิษฐ์
#     Input Text    id=shipping-form-last-name-input    text=วนกิจรุ่งเรือง
#     Input Text    id=shipping-form-address-input    text=159/49 หมู่บ้านดลลชา ซอยสุขสวัสดิ์ 70
#     Click Button    id=shipping-form-province-select
#     Select From List By Value    id=shipping-form-province-select    1
#     Click Button    id=shipping-form-district-select
#     Select From List By Value    id=shipping-form-district-label    1049
#     Click Button    id=shipping-form-sub-district-select
#     Select From List By Value    id=shipping-form-sub-district-select    104902
#     Element Should Contain    id=shipping-form-zipcode-input    10140
#     Input Text    id=shipping-form-mobile-input    text=0626752828
#     Click Button    id=shipping-method-1-card
#     Input Text    id=payment-credit-form-fullname-input    text=พิสิษฐ์ วนกิจรุ่งเรือง
#     Input Text    id=payment-credit-form-card-number-input    text=1234567891014569
#     Input Text    id=payment-credit-form-expiry-input    text=11/28
#     Input Text    id=payment-credit-form-cvv-input    text=589
#     Element Should Contain    id=order-summary-subtotal-price    4,314.60
#     Element Should Contain    id=order-summary-receive-point-price    43 Points
#     Element Should Contain    id=order-summary-shipping-fee-price    50.00
#     Element Should Contain    id=order-summary-total-payment-price    4,364.60
#     Click Button    id=payment-now-btn

# หน้า SCK Payment Gateway

#     Page Should Contain    4,364.60
#     Click Button    class=text-sm font-normal px-6 py-2 bg-gray-300 text-black hover:bg-gray-400 focus:ring-gray-500 bg-gray-300 text-black hover:bg-gray-400 flex items-center justify-center rounded-md border border-transparent focus:outline-none focus:ring-2 focus:ring-offset-2
#     Input Text    id=otp-input   text=789456
#     Click Button    class=text-sm font-normal px-6 py-2 bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500 undefined flex items-center justify-center rounded-md border border-transparent focus:outline-none focus:ring-2 focus:ring-offset-2
    
# หน้า Notification

#     Page Should Contain    25/11/2025 10:45:54***
#     Page Should Contain    KR-280761702***
#     Input Text    id=notification-form-email-input    text=pisit.wana@gmail.com
#     Input Text    id=notification-form-mobile-input    text=0626752828
#     Select Checkbox    id=notification-form-in-application-input
#     Click Button    id=send-notification-btn
#     Handle Alert    ACCEPT

*** Keywords ***

Reset App State
    # 1. Delete cookies to log out or clear session
    Delete All Cookies