import { test, expect } from "@playwright/test";

test("Check Landing page text", async ({ page }) => {
  await page.goto("/automating-stuff/");

  await expect(page.getByTestId("staging-header")).toHaveText(
    "STAGING ENVIRONMENT"
  );
  await expect(page.getByTestId("description-text")).toHaveText(
    "This environment is used to practice deployment via GitActions, as well as ci/cd flow in general."
  );
});
