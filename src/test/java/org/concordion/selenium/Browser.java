package org.concordion.selenium;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.events.EventFiringWebDriver;
//import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Manages the browser session.
 */
public class Browser {
    private WebDriver driver;

    public Browser() {
        driver = new FirefoxDriver();
//        driver = new ChromeDriver();
//        driver = new PhantomJSDriver();
         EventFiringWebDriver efwd = new EventFiringWebDriver(driver);
         efwd.register(new SeleniumEventLogger());
         driver = efwd;
    }

    public void close() {
        if (driver != null) {
            driver.quit();
            driver = null;
        }
    }

    public WebDriver getDriver() {
        return driver;
    }
}