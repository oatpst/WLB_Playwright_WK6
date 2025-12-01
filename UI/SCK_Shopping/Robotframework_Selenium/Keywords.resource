*** Keywords ***

#การใช้ Contain ถ้ามีบางส่วนก็จะถือว่า ผ่าน ควรจะมีการตรวจสอบหลังจากที่ Wait แล้ว


ค้นหาสินค้าและเลือกสินค้าที่ต้องการ

    [Arguments]    ${product_name}    ${product_price}
    Open Browser    url=${URL}    browser=${BROWSER}
	Wait Until Element Is Visible    id=search-product-input
    Input Text    id=search-product-input    text=${productname}
    Press Keys    id=search-product-input    RETURN
    Wait Until Element Contains    id=product-card-name-1    ${productname}
	Page Should Contain    text=${product_price}
	Element Should Contain    id=header-menu-cart-badge    0
	#ควรเอาลงไปอยู่เคสด้านล่าง ต้องเริ่มจาก Action เสมอ
    Click Element    id=product-card-name-1

ตรวจสอบรายละเอียดสินค้าและจำนวนที่ต้องการสั่งซื้อ

    [Arguments]    ${product_name}    ${product_category}    ${product_price}    ${product_points}
    Page Should Contain    ${product_name}
    Page Should Contain    ${product_category}
    Page Should Contain    ${product_price}
    Page Should Contain    ${product_points}
    Page Should Contain Image    id=product-detail-image
	#ควรเอาลงไปอยู่เคสด้านล่าง
    Click Button    id=product-detail-add-to-cart-btn

ตรวจสอบตะกร้าสินค้าและเตรียมก่อนการชำระเงิน

    [Arguments]    ${product_name}    ${product_price}    ${product_points}
    Click Button    id=header-menu-cart-btn
    Page Should Contain    Shopping cart
    Page Should Contain    ${product_name}
    Wait Until Element Contains    id=product-1-price    ${product_price}
    Page Should Contain    ${product_points}
    Element Should Contain    id=shopping-cart-subtotal-price    ${product_price}
    Click Element    id=shopping-cart-checkout-btn

ตรวจสอบสินค้าในหน้า CHECKOUT

#ระวังเรื่องการใช้ Contain เพราะจะมีเคสแปลกๆ และโค้ดจะใช้งานไม่ได้
    [Arguments]    ${product_price}    ${product_points}
	Element Should Contain    id=header-menu-cart-badge    1
    Wait Until Element Contains    id=product-1-price    ${product_price}
    Wait Until Element Contains    id=product-1-point    ${product_points}

กรอกข้อมูลการจัดส่ง 

#อย่าย่อตัวแปรคนอื่นไม่รู้เรื่องด้วย
    [Arguments]    ${cus_name}    ${cus_surname}    ${cus_add}    ${cus_province}    ${cus_district}    ${cus_sub_district}    ${cus_tel}
    Input Text    id=shipping-form-first-name-input    text=${cus_name}
    Input Text    id=shipping-form-last-name-input    text=${cus_surname}
    Input Text    id=shipping-form-address-input    text=${cus_add}
    Click Element    id=shipping-form-province-select
    Select From List By Label    id=shipping-form-province-select    ${cus_province}
    Click Element    id=shipping-form-district-select
    Select From List By Label    id=shipping-form-district-select    ${cus_district}
    Click Element    id=shipping-form-sub-district-select
    Select From List By Label    id=shipping-form-sub-district-select    ${cus_sub_district}
    Element Attribute Value Should Be    id=shipping-form-zipcode-input    value    10140
    Input Text    id=shipping-form-mobile-input    text=${cus_tel}

เลือกวิธีการจัดส่งและ กรอกข้อมูลการชำระเงิน

    [Arguments]    ${cus_fullname}    ${cus_card_num}    ${cus_expiry}    ${cus_cvv}
    Click Element    id=shipping-method-1-card
    Input Text    id=payment-credit-form-fullname-input    text=${cus_fullname}
    Input Text    id=payment-credit-form-card-number-input    text=${cus_card_num}
    Input Text    id=payment-credit-form-expiry-input    text=${cus_expiry}
    Input Text    id=payment-credit-form-cvv-input    text=${cus_cvv}

ตรวจสอบยอดรวมคำสั่งซื้อและแต้มที่ได้รับ

#ต้องเช็คหลังจาก Wait เสมอ
    [Arguments]    ${product_price}    ${product_points}    ${shipping_fee}    ${summary_price}
    Wait Until Element Contains    id=order-summary-subtotal-price    ${product_price}
    Wait Until Element Contains    id=order-summary-receive-point-price    ${product_points}
    Wait Until Element Contains    id=order-summary-shipping-fee-price    ${shipping_fee}
    Wait Until Element Contains    id=order-summary-total-payment-price    ${summary_price}
    Click Button    id=payment-now-btn

กรอกรหัส OTP และ ยืนยันการชำระเงิน

    [Arguments]    ${summary_price}    ${OTP}
    Wait Until Page Contains    SCK Payment Gateway
    Page Should Contain    ${summary_price}
    Input Text    id=otp-input   text=${OTP}
	Click Element    css=button[color='primary']
	# ถ้ามีหลายปุ่มจุดนี้ควรจะแก้ไข เพราะมันจะจับตัวแรกที่เจอ

กรอกข้อมูลการแจ้งเตือนและกลับสู่หน้าแรกของ Website

    [Arguments]    ${customer_email}    ${customer_tel}
    # Page Should Contain    25/11/2025 10:45:54***
    # Page Should Contain    KR-280761702***
    Wait Until Page Contains Element    id=notification-form-email-input
	# ใช้เป็น Visible ไม่รู้ว่า ตัวไหนต้องรอบ้าง เพราะฉะนั้นดูตามหน้างาน
    Wait Until Page Contains Element    id=notification-form-mobile-input
    Input Text    id=notification-form-email-input    text=${customer_email}
    Input Text    id=notification-form-mobile-input    text=${customer_tel}
    Select Checkbox    id=notification-form-in-application-input
    Click Button    id=send-notification-btn
    Handle Alert    ACCEPT

Reset App State
    # 1. Delete cookies to log out or clear session
    Delete All Cookies
	Close Browser