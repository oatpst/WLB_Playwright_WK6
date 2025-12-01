*** Keywords ***

ค้นหาสินค้าและตรวจสอบการค้นหาว่าเป็นสินค้าที่ถูกต้องตามที่ค้นหา

    [Arguments]    ${product_name}    ${product_price}
    Open Browser    url=${URL}    browser=${BROWSER}
	Wait Until Element Is Visible    id=search-product-input
	Element Text Should Be    id=header-menu-cart-badge    0
    Input Text    id=search-product-input    text=${productname}
    Press Keys    id=search-product-input    RETURN
    Wait Until Element Is Visible    id=product-card-name-1
	Element Text Should Be    id=product-card-name-1    ${productname}
	Element Text Should Be    id=product-card-price-1    ${product_price}

ตรวจสอบรายละเอียดสินค้าและจำนวนที่ต้องการสั่งซื้อ

    [Arguments]    ${product_name}    ${product_brand}    ${product_price}    ${product_points}
	Click Element    id=product-card-name-1
	Wait Until Element Is Visible    id=product-detail-add-to-cart-btn
    Element Text Should Be    id=product-detail-product-name    ${product_name}
    Element Text Should Be    id=product-detail-brand    ${product_brand}
    Element Text Should Be    id=product-detail-price-thb    ${product_price}
    Element Text Should Be    id=product-detail-point    ${product_points}
    Page Should Contain Image    id=product-detail-image

ตรวจสอบตะกร้าสินค้าและการเตรียมการก่อนการชำระเงิน

    [Arguments]    ${product_name}    ${product_price}    ${product_points}
    Click Button    id=product-detail-add-to-cart-btn
    Click Button    id=header-menu-cart-btn
    Wait Until Element Is Visible    id=shopping-cart-subtotal-price
    Element Text Should Be    id=product-1-name    ${product_name}
    Wait Until Element Is Visible    id=product-1-price
    Element Text Should Be    id=product-1-point    ${product_points}
    Element Text Should Be    id=shopping-cart-subtotal-price    ${product_price}

ตรวจสอบสินค้าในหน้า CHECKOUT

    [Arguments]    ${product_price}    ${product_points}
    Click Element    id=shopping-cart-checkout-btn
	Element Text Should Be    id=header-menu-cart-badge    1
    Wait Until Element Contains    id=product-1-price    ${product_price}
	Element Text Should Be    id=product-1-price    ${product_price}
	Element Text Should Be    id=product-1-point    ${product_points}

# กรอกข้อมูลการจัดส่ง 

#     [Arguments]    ${customer_name}    ${customer_surname}    ${customer_add}    ${customer_province}    ${customer_district}    ${customer_sub_district}    ${customer_tel}
#     Input Text    id=shipping-form-first-name-input    text=${customer_name}
#     Input Text    id=shipping-form-last-name-input    text=${customer_surname}
#     Input Text    id=shipping-form-address-input    text=${customer_add}
#     Click Element    id=shipping-form-province-select
#     Select From List By Label    id=shipping-form-province-select    ${customer_province}
#     Click Element    id=shipping-form-district-select
#     Select From List By Label    id=shipping-form-district-select    ${customer_district}
#     Click Element    id=shipping-form-sub-district-select
#     Select From List By Label    id=shipping-form-sub-district-select    ${customer_sub_district}
#     Element Attribute Value Should Be    id=shipping-form-zipcode-input    value    10140
#     Input Text    id=shipping-form-mobile-input    text=${customer_tel}

กรอกข้อมูลการจัดส่ง 

# ทดลองใช้ Dictionary โดยการประกาศตัวแปรเพื่อรับค่าให้อยู่ในชุดเดียวกัน

    [Arguments]    ${name}    ${surname}    ${address}    ${province}    ${district}    ${sub_district}    ${telephone}
    ${customer}=    Create Dictionary    name=${name}    surname=${surname}    address=${address}    province=${province}    district=${district}    sub_district=${sub_district}    telephone=${telephone}
    Input Text    id=shipping-form-first-name-input    text=${customer.name}
    Input Text    id=shipping-form-last-name-input    text=${customer.surname}
    Input Text    id=shipping-form-address-input    text=${customer.address}
    Click Element    id=shipping-form-province-select
    Select From List By Label    id=shipping-form-province-select    ${customer.province}
    Click Element    id=shipping-form-district-select
    Select From List By Label    id=shipping-form-district-select    ${customer.district}
    Click Element    id=shipping-form-sub-district-select
    Select From List By Label    id=shipping-form-sub-district-select    ${customer.sub_district}
    Element Attribute Value Should Be    id=shipping-form-zipcode-input    value    10140
    Input Text    id=shipping-form-mobile-input    text=${customer.telephone}


เลือกวิธีการจัดส่งและ กรอกข้อมูลการชำระเงิน

    [Arguments]    ${fullname}    ${card_number}    ${expiry}    ${cvv}
	${customer_card_detail}=    Create Dictionary    fullname=${fullname}    card_number=${card_number}    expiry=${expiry}    cvv=${cvv}
    Click Element    id=shipping-method-1-card
    Input Text    id=payment-credit-form-fullname-input    text=${customer_card_detail.fullname}
    Input Text    id=payment-credit-form-card-number-input    text=${customer_card_detail.card_number}
    Input Text    id=payment-credit-form-expiry-input    text=${customer_card_detail.expiry}
    Input Text    id=payment-credit-form-cvv-input    text=${customer_card_detail.cvv}

ตรวจสอบยอดรวมคำสั่งซื้อและแต้มที่ได้รับ

    [Arguments]    ${product_price}    ${product_points}    ${shipping_fee}    ${summary_price}
	Wait Until Element Is Visible    id=order-summary-total-payment-price
    Element Text Should Be    id=order-summary-subtotal-price    ${product_price}
    Element Text Should Be    id=order-summary-receive-point-price    ${product_points}
    Element Text Should Be    id=order-summary-shipping-fee-price    ${shipping_fee}
    Element Text Should Be    id=order-summary-total-payment-price    ${summary_price}

กรอกรหัส OTP และ ยืนยันการชำระเงิน

    Click Button    id=payment-now-btn
    [Arguments]    ${summary_price}    ${OTP}
    Wait Until Element Is Visible    id=otp-input
    Page Should Contain    ${summary_price}
    Input Text    id=otp-input   text=${OTP}
    Click Button    PAY NOW

กรอก Email และเบอร์โทรศัพท์เพื่อรับการแจ้งเตือนคำสั่งซื้อ

    [Arguments]    ${customer_email}    ${customer_telephone}
    Wait Until Element Is Visible    id=notification-form-email-input
    Input Text    id=notification-form-email-input    text=${customer_email}
	Wait Until Element Is Visible    id=notification-form-mobile-input
    Input Text    id=notification-form-mobile-input    text=${customer_telephone}
    Select Checkbox    id=notification-form-in-application-input
    Click Button    id=send-notification-btn
    Handle Alert    ACCEPT

Reset App State

    #ค่าบางอย่างอาจจะหายไป
    Delete All Cookies
	Close Browser