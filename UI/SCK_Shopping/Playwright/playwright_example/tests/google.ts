// import { test, expect } from '@playwright/test';

// test('Open Google And Verify Title', async ({ page }) => {

//   // เข้าหน้าเว็บ
//   await page.goto('https://www.google.com');

//   // ใส่คำค้นหา จะรอดในกรณีที่เป็นตัวแรก
//   const searchInputText = await page.getByRole('combobox');

//   searchInputText.fill('ร้านอาหารญี่ปุ่นใกล้ฉัน');

//   searchInputText.press('Enter');

//   // ตรวจสอบผลการค้นหา
// //   const locator = page.locator('class=LC20lb MBeuO DKV0Md')
//   await expect(page.getByText('เท็นชิโนะ')).toBeVisible();
// });