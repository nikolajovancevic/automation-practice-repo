import { test, expect } from "@playwright/test";

test("Check Landing page text", async ({ page }) => {
  await page.goto("https://bloxico.com/");
  
  await page.waitForTimeout(1000)
  console.log("timeout expired")
  await page.goto("https://localhost:3000");
  await page.waitForTimeout(1000)


  await expect(page.getByTestId("page-title-text")).toHaveText(
    "DEVELOPMENT ENVIRONMENT",
  );
  await expect(page.getByTestId("description-text")).toHaveText(
    "This environment is used to practice deployment via GitActions, as well as ci/cd flow in general.",
  );
});
