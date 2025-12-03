import { test, expect } from '@playwright/test';

const loginData = [
	{
		"test_case" : "Login success",
		"username" : "demo",
		"password" : "mode",
		"expectedMessage" : "Login succeeded."
	},

	{
		"test_case" : "Login Failed: กรณีกรอก Username ผิด",
		"username" : "demoo",
		"password" : "mode",
		"expectedMessage" : "Login failed"
	},

	{
		"test_case" : "Login Failed: กรณีกรอก Password ผิด",
		"username" : "demo",
		"password" : "modee",
		"expectedMessage" : "Login failed"
	},

	{
		"test_case" : "Login Failed: กรณีกรอก Username และ Password ผิด",
		"username" : "demoo",
		"password" : "modee",
		"expectedMessage" : "Login failed"
	},

	{
		"test_case" : "Login Failed: กรณีไม่กรอก Username แต่กรอก Password",
		"username" : "",
		"password" : "mode",
		"expectedMessage" : "Login failed"
	},

	{
		"test_case" : "Login Failed: กรณีกรอก Username ถูก แต่ไม่กรอก Password",
		"username" : "demo",
		"password" : "",
		"expectedMessage" : "Login failed"
	},

	{
		"testCase" : "Login Failed: กรณีไม่กรอกทั้ง Username และ Password",
		"username" : "",
		"password" : "",
		"expectedMessage" : "Login failed"
	},
];

loginData.forEach(({testCase, username, password, expectedMessage}) => {

	test(`${testCase}`, async ({ page }) => {

		await test.step('เข้าหน้าเว็บ', async () => {
			await page.goto('/');
		});

		await test.step('ใส่ Username และ Password', async () => {

			await page.locator("[id='username_field']").fill(username);
			await page.locator("[id='password_field']").fill(password);
			await page.locator('#login_button').click();

		});

		await test.step('ตรวจสอบผลการ Login', async () => {

			await expect(page.getByText(expectedMessage)).toBeVisible();

		});
	});
});