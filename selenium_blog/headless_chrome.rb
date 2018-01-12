require 'selenium-webdriver'

# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
# options.add_argument('--disable-gpu')
# options.add_argument('--remote-debugging-port=9222')
# driver = Selenium::WebDriver.for :chrome, options: options

switches = %w[--test-type --ignore-certificate-errors --disable-popup-blocking --disable-translate --headless --disable-gpu]
driver = Selenium::WebDriver.for :chrome, :switches => switches
driver.get "https://www.jd.com"
driver.save_screenshot("#{File.dirname(__FILE__)}/#{Time.now.strftime("%F")}.png")