require 'selenium-webdriver'
require 'fileutils'
require "pry"
require 'time'

def setup  
  download_dir = File.join(Dir.pwd, 'new_folder'+ Time.now.to_s)  
  FileUtils.mkdir_p download_dir  
  # Firefox  
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.dir'] = download_dir

  profile['browser.download.folderList'] = 2
  # It tells Firefox which download directory to use. 
  # 2 tells it to use a custom download path, wheras 1 would use the browser's default path, and 0 would place them on the Desktop.
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'images/jpeg, application/pdf, application/octet-stream, application/zip'  
  profile['pdfjs.disabled'] = true  
  @driver = Selenium::WebDriver.for :firefox, profile: profile
end

setup

@driver.get "https://rubygems.org/pages/download"
download_link = @driver.find_element(:xpath, "//a[text()='zip']")
wait = Selenium::WebDriver::Wait.new()  
wait.until { download_link.displayed? }
download_link.click
