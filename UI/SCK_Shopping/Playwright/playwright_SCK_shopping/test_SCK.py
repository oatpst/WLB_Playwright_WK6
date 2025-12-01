import re
from playwright.sync_api import Page, expect

def test_has_title(page: Page):
	page.goto("http://sck-dojo.ddns.net:8000/")

	expect(page).to_have_title(re.compile("Log in"))
