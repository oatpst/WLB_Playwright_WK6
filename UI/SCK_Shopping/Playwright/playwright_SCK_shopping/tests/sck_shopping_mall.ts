import { test, expect } from '@playwright/test';

test('การทดสอบการสั่งซื้อสินค้าของลูกค้าที่ลูกค้าชำระเงินสำเร็จ', async ({ page }) => {

	await test.step('เข้าสู่หน้าเว็บไซต์', async () => {
		await page.goto('http://sck-dojo.ddns.net:8000/product/list');
	});

	await test.step('ค้นหาสินค้าและตรวจสอบการค้นหาว่าเป็นสินค้าที่ถูกต้องตามที่ค้นหา', async () => {

		const searchProduct = await page.locator("[id='search-product-input']");
		searchProduct.fill('Balance Training Bicycle');
		searchProduct.press('Enter');
		await expect(page.locator("[id='header-menu-cart-badge']")).toHaveText('0');
		await expect(page.locator("[id='product-card-name-1']")).toHaveText('Balance Training Bicycle');
		await expect(page.locator("[id='product-card-price-1']")).toHaveText('฿4,314.60');

	});

	await test.step('ตรวจสอบรายละเอียดสินค้าและจำนวนที่ต้องการสั่งซื้อ', async () => {

		await page.locator("[id='product-card-name-1']").click();
		await expect(page.locator("[id='product-detail-product-name']")).toHaveText('Balance Training Bicycle');
		await expect(page.locator("[id='product-detail-brand']")).toHaveText('SportsFun');
		await expect(page.locator("[id='product-detail-price-thb']")).toHaveText('฿4,314.60');
		await expect(page.locator("[id='product-detail-point']")).toHaveText('43 Points');

	});

	await test.step('ตรวจสอบตะกร้าสินค้าและการเตรียมการก่อนการชำระเงิน', async () => {

		await page.getByText('Add to cart').click();
		await page.locator("[id='header-menu-cart-btn']").click();
		await expect(page.locator("[id='product-1-name']")).toHaveText('Balance Training Bicycle');
		await expect(page.locator("[id='product-1-price']")).toHaveText('฿4,314.60');
		await expect(page.locator("[id='product-1-point']")).toHaveText('43 Points');
		await expect(page.locator("[id='shopping-cart-subtotal-price']")).toHaveText('฿4,314.60');

	})

	await test.step('ตรวจสอบสินค้าในหน้า CHECKOUT', async () => {

		await page.locator("[id='shopping-cart-checkout-btn']").click();
		await expect(page.locator("[id='product-1-image']")).toBeVisible();
		await expect(page.locator("[id='product-1-price']")).toHaveText('฿4,314.60');
		await expect(page.locator("[id='product-1-point']")).toHaveText('43 Points');

	})

	await test.step('กรอกข้อมูลการจัดส่ง', async () => {

		await page.locator("[id='shipping-form-first-name-input']").fill('พิสิษฐ์');
		await page.locator("[id='shipping-form-last-name-input']").fill('วนกิจรุ่งเรือง');
		await page.locator("[id='shipping-form-address-input']").fill('159/49 หมู่บ้านดลลชา');
		await page.locator("[id='shipping-form-province-select']").selectOption('กรุงเทพมหานคร');
		await page.locator("[id='shipping-form-district-select']").selectOption('เขตทุ่งครุ');
		await page.locator("[id='shipping-form-sub-district-select']").selectOption('ทุ่งครุ');
		await expect(page.locator("[id='shipping-form-zipcode-input']")).toHaveAttribute('value', '10140');
	})

	await test.step('เลือกวิธีการจัดส่งและ กรอกข้อมูลการชำระเงิน', async () => {

	} )
});

