import { test, expect } from '@playwright/test';

// test('ทดสอบการค้นหา', async ({ page }) => {

// 	await page.goto('https://th.kex-express.com/th/home');
// 	await page.getByPlaceholder('กรอกเลขพัสดุ').fill('SDOF5208664423');

// const popupPromise = page.waitForEvent('popup');
// 	await page.getByPlaceholder('กรอกเลขพัสดุ').press('Enter');
// 	const newPage = await popupPromise;
// 	await expect(newPage.locator("span.con")).toHaveText('SDOF5208664423');
// 	const textDate = await newPage.locator('.text-1418.light');
	
// 	await expect(page.locator('.text-1418.light').nth(1)).toContainText('วันที่ 03 ธ.ค. 2568');


// 	const now = new Date();
// 	const bangkokTime = now.toLocaleTimeString('en-US', {
//   	timeZone: 'Asia/Bangkok',
//   	hour: '2-digit',
//   	minute: '2-digit',
//   	hour12: false
// 	}); 
// 	await expect(page.locator('.text-1418.light'.nth(2)).toContainText(bangkokTime);
// });

test('การค้นหา Case2 ในหน้า Tracking เลย', async ({ page }) => {

	await page.goto('https://th.kex-express.com/en/track/');
	await page.locator("input.tracking-input").click();
	await page.locator("textarea.textarea-scroll").fill('SDOF5208664423');
	await page.locator("button.ke-btn-search").click();

	await expect(page.locator("span.con")).toHaveText('SDOF5208664423');
	await expect(page.locator('.text-1418.light').nth(1)).toContainText('Date 03 Dec 2025');


	const now = new Date();
	const bangkokTime = now.toLocaleTimeString('en-US', {
  	timeZone: 'Asia/Bangkok',
  	hour: '2-digit',
  	minute: '2-digit',
  	hour12: false
	}); 
	await expect(page.locator('.text-1418.light').nth(2)).toContainText(bangkokTime);


});
