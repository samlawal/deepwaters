# Generated by Selenium IDE
require 'selenium-webdriver'
require 'json'
describe 'TestCapture' do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @vars = {}
  end
  after(:each) do
    @driver.quit
  end
  it 'testCapture' do
    @driver.get('https://brokers.leaseplan.co.uk/login.asp?urlRedirect=%2fdashboard.asp')
    @driver.find_element(:id, 'txtuserNameWPQ1_DOCQ1').click
    @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').send_keys('Damien.fortune@autorama.co.uk')
    @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').click
    @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').send_keys('Autorama1')
    @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').send_keys(:enter)
  end
end
