import { test, expect } from "@playwright/test";

test("Check Landing page text", async ({ page }) => {
  await page.goto("/");

  await expect(page.getByTestId("test-env-header")).toHaveText(
    "Test Environment"
  );
  await expect(page.getByTestId("description-text")).toHaveText(
    "Dzon's environment used to practice deployment via GitActions, as well as CI/CD flow."
  );
});
