#encoding=UTF-8
require 'selenium-webdriver'
require "pry"
require "yaml"

def wait_element_display(element)
  wait = Selenium::WebDriver::Wait.new()  
  wait.until { element.displayed? }
end

def wait_element_display_then_click(element)
  wait_element_display(element)
  element.click
end

def store_cookies
  $dr.get("http://www.jd.com/")
  #manual login
  binding.pry
  File.new("config.yml", "w+") if not File.exist? "#{File.dirname(__FILE__)}/config.yml"
  IO.write("#{File.dirname(__FILE__)}/config.yml", $dr.manage.all_cookies.to_yaml)
end


$dr = Selenium::WebDriver.for :firefox
$dr.get("http://www.jd.com/")
$dr.manage.delete_all_cookies
store_cookies
cookies = YAML.load(File.open("config.yml"))
cookies.each do |cookie|
  $dr.manage.add_cookie(cookie)
end

begin
  $dr.get("http://www.jd.com/")

  coupon_link = $dr.find_element(:link_text, "优惠券")
  wait_element_display_then_click(coupon_link)
  $dr.action.send_keys([:command, :alt, :right]).perform
  binding.pry

  coupons = $dr.find_elements(:xpath, "//span[text()='立即领取']")
  binding.pry
rescue => exception
  puts exception
ensure
  $dr.close
end


