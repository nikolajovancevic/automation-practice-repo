import { test, expect } from "@playwright/test";

test("Check Landing page text", async ({ page }) => {
  await page.goto("/");

  await expect(page.getByTestId("test-env-header")).toHaveText(
    "Test Environment",
  );
  await expect(page.url()).toContain("automating-stuff/")
});
