# coding: utf-8
require 'selenium-webdriver'

def highlight(element, duration = 3)

  # 保留元素原有的style，以待方法执行完成后恢复
  original_style = element.attribute("style")

  # 给元素加一个红色的虚线边界
  $driver.execute_script(
    "arguments[0].setAttribute(arguments[1], arguments[2])",
    element,
    "style",
    "border: 2px solid red; border-style: dashed;")

  # 让元素的边界保留一段时间再恢复
  if duration > 0
    sleep duration
    $driver.execute_script(
      "arguments[0].setAttribute(arguments[1], arguments[2])",
      element,
      "style",
      original_style)
  end
end

begin
    $driver = Selenium::WebDriver.for :firefox
    $driver.get 'https://www.jianshu.com'
    highlight $driver.find_element(xpath: "//a[@class='logo']")
ensure
    $driver.quit
end
