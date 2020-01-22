require 'rubygems'
require 'selenium-webdriver'
require 'pry'
require 'rspec'
require 'open-uri'
require 'openssl'
require 'nokogiri'

puts OpenSSL::OPENSSL_VERSION
puts "SSL_CERT_FILE: %s" % OpenSSL::X509::DEFAULT_CERT_FILE
puts "SSL_CERT_DIR: %s" % OpenSSL::X509::DEFAULT_CERT_DIR



# prefs = {
#   plugins: {
#     plugins_disabled: ['Chrome PDF Viewer']
#   },
#   download: {
#     prompt_for_download: false,
#     directory_upgrade:   true,
#     default_directory: "/testdata"
#   }
# }
prefs = {
  plugins: {
    always_open_pdf_externally: true
  },
  download: {
     prompt_for_download: false,
     directory_upgrade:   true,
     default_directory: "/testdata"
   }
}
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--ignore-certificate-errors')
  options.add_argument('--disable-popup-blocking')
  options.add_argument('--disable-translate')
  options.add_argument('start-maximized')
  options.add_preference(:download, prefs)

    @driver = Selenium::WebDriver.for :chrome
    #@driver = Selenium::WebDriver.for :chrome, options: options

    @driver.manage.delete_all_cookies # seconds
    @driver.manage.timeouts.implicit_wait = 30 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds

    def download_url
    get_url = @driver.current_url
    #get_url_parse = URI.parse(get_url).open(:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read

    #download = open(get_url_parse,  :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] )
    #doc = Nokogiri::HTML(open(url, :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] ))
    download = open(get_url)
    IO.copy_stream(download, '~/testdata/my_file.pdf')
    end

    @vars = {}
    take_five =  1000

def wait_for_window(timeout = 2)
  #sleep(round(timeout / 1000))
  sleep(timeout / 1000)
  wh_now = @driver.window_handles
  wh_then = @vars['window_handles']
  wh_now.find { |window| window != wh_then.first}
  rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def wait_for_element_by_id(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:id => element) }
  ensure
    #driver.quit
  end
end

def wait_for_element_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds

    wait.until { driver.find_element(:link_text => element) }
end

def wait_for_element_to_be_enabled_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:link_text => element).displayed? }
    wait.until { driver.find_element(:link_text => element).enabled? }
  ensure
    #driver.quit
  end
end

def wait_until_element_appears(driver, locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  wait.until { driver.find_element(locator, name).displayed? }
end

def wait_until_element_appears_by_id(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  begin
    wait.until { driver.find_element(:id => element).displayed? }
    wait.until { driver.find_element(:id => element).enabled? }

  ensure
    #driver.quit
  end
end

def is_element_enabled(driver, locator, element ) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 20) #
  begin
    #element = wait.until { driver.find_element(:id => element).enabled? }
    wait.until { driver.find_element(locator, element).enabled? }
  ensure
    #driver.quit
  end
end


def wait_until_disappears(long_press_on_coordinates_with_duration, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  wait.until { !@driver.find_element(locator, name).displayed? }
end



def wait_until_element_is_enabled(driver, type, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  wait.until { driver.find_element(type => name).enabled? }
end

  @driver.get('https://brokers.leaseplan.co.uk/login.asp?')
  @driver.manage.window.maximize
  #binding.pry
  @driver.find_element(:id, 'txtuserNameWPQ1_DOCQ1').click
  @driver.find_element(:id, 'txtuserNameWPQ1_DOCQ1').send_keys('Damien.fortune@autorama.co.uk')
  @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').click
  @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').send_keys('Autorama1')
  @driver.find_element(:id, 'txtpassWordWPQ1_DOCQ1').send_keys(:enter)


  def switch_to_window_with_text(target)
    index   = 0
    handles = @driver.window_handles
    windows.each do |window|
      if window.text.include?(target)
        @driver.switch_to.window(handles[index])
        break
      end
      index += 1 
    end
  end

  def switch_to_window_with_text(target)
    index   = 0
    handles = @driver.window_handles
    @browser.windows.each do |window|
      if window.text.include?(target)
        @driver.switch_to.window(handles[index])
        break
      end
      index += 1
    end
  end

  def page_has_loaded(browser)
    wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
    page_state = browser.execute_script(
      'return document.readyState;'
    )
    wait.until { return page_state == 'complete' }
  end
    #@driver.find_element(:xpath  => "//div[@class='ap-loginmask-button ap-login-action']//button[@class='ap-button']").click
  def accept_cookies (driver)
    testcon = driver.find_element(:css, '.accept-cookies-button')
    if (testcon.displayed?)
      testcon.click
    end
  rescue StandardError => e
     puts "Rescued: #{e.inspect}"
  end

   def switch_handles ()
      @vars['window_handles'] = @driver.window_handles
      @vars['win7761'] = wait_for_window(2000)
      @vars['root'] = @driver.window_handle
      @driver.switch_to.window(@vars['win7761'])
   end

   wait_for_window(take_five)
   page_has_loaded(@driver)
   #@driver.find_element(:css, '.ap-login-action span').click

  accept_cookies(@driver)


    @vars['window_handles'] = @driver.window_handles
    @driver.find_element(:link_text, 'NeMO').click
    @vars['win7761'] = wait_for_window(2000)
    @vars['root'] = @driver.window_handle
    @driver.switch_to.window(@vars['win7761'])
    wait_for_window(take_five)
    @driver.execute_script("window.scrollTo(0,213.3333282470703)")
    wait_for_window(take_five)
    wait_until_element_appears_by_id(@driver, 'j_id0:idform:j_id3:j_id103')
    page_has_loaded(@driver)
    @driver.find_element(:id, 'j_id0:idform:j_id3:j_id103').click
    page_has_loaded(@driver)
    @driver.find_element(:link_text, 'ACCEPT').click
    page_has_loaded(@driver)
    wait_for_window(take_five)
    @driver.find_element(:link_text, 'ACCEPT').click
    page_has_loaded(@driver)
    wait_for_window(take_five)
    @driver.find_element(:link_text, 'ACCEPT').click
    page_has_loaded(@driver)
    wait_for_window(take_five)
    @driver.find_element(:link_text, 'SELECT').click
    page_has_loaded(@driver)
    wait_for_window(take_five)


    # Customer details
    wait_for_window(take_five)
    wait_until_element_appears_by_id(@driver,'j_id0:form:j_id5:Idfirstname')
    @driver.find_element(:id, 'j_id0:form:j_id5:Idfirstname').click
    @driver.find_element(:id, 'j_id0:form:j_id5:Idfirstname').send_keys('Liam')
    @driver.find_element(:name, 'j_id0:form:j_id5:j_id314').click
    @driver.find_element(:name, 'j_id0:form:j_id5:j_id314').send_keys('Meehan')
    @driver.find_element(:id, 'j_id0:form:j_id5:idDay').click
    @driver.find_element(:id, 'j_id0:form:j_id5:idDay').send_keys('17')
    @driver.find_element(:id, 'j_id0:form:j_id5:idMonth').click
    @driver.find_element(:id, 'j_id0:form:j_id5:idMonth').send_keys('02')
    @driver.find_element(:id, 'j_id0:form:j_id5:idYear').click
    @driver.find_element(:id, 'j_id0:form:j_id5:idYear').send_keys('1994')
    @driver.find_element(:id, 'j_id0:form:j_id5:idPostCode').click
    @driver.find_element(:id, 'j_id0:form:j_id5:idPostCode').send_keys('hp2 7bw')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode1').click
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode1').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode2').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode3').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode4').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode5').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idSortCode6').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode1').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode2').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode3').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode4').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode5').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode6').send_keys('1')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode7').send_keys('0')
    @driver.find_element(:id, 'j_id0:form:j_id5:idACode8').send_keys('1')
    element = @driver.find_element(:css, '.button')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:css, '.button')
    @driver.action.move_to(element).perform
    element = @driver.find_element(:css, '.button')
    @driver.action.move_to(element).release.perform
    wait_for_window(take_five)
    @driver.find_element(:css, '.button').click
    @driver.execute_script("window.scrollTo(0,1248)")
    page_has_loaded(@driver)
    wait_for_window(take_five)
    #binding.pry
    @driver.find_element(:css, '.walkme-custom-balloon-title').click
    @driver.find_element(:css, '.walkme-custom-balloon-button-text').click

    #signatory direct debit
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:checkbox1').click
    wait_for_window(take_five)

    switch_handles()
    wait_for_window(take_five)
    #@driver.switch_to.default_content
    #@driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id461\:j_id462\:j_id465\:0\:j_id473 > button').click

#############################



########

    #@driver.find_element(:css, '.address__c_to__c').click
    wait_for_window(take_five)
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id650').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').send_keys :clear
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').send_keys('02071234567')
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idemail').click

    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys :clear
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys('07123456789')
    @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id651 > button').click

     #########################################
    #      BANK ACCOUNT DETAILS  - New page #
    ##########################################

    wait_for_window(take_five)
    @driver.find_element(:link_text, 'AGREE').click
    #click on next button

  #  if @driver.find_element(:css, '.walkme-custom-balloon-title').displayed?
  #   @driver.find_element(:css, '.walkme-custom-balloon-title').click
  #   @driver.find_element(:css, '.walkme-custom-balloon-button-text').click
  #  end

     # Agree
    wait_for_window(take_five)
    @driver.find_element(:link_text, 'AGREE').click

    # confirm
    @driver.find_element(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a').click

    # save and continue
    @driver.find_element(:id, 'j_id0:idfrm:j_id8:j_id332').click


   ##########################################
    #      EMPLOYMENT DETAILS  - New page #
   ##########################################
    @driver.execute_script("window.scrollTo(0,5.333333492279053)")
    wait_for_window(take_five)
#####


####
    wait_for_element_by_id(@driver,'j_id0:idfrm:j_id4:selectSelectBoxItText')
    @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText').click
    wait_for_window(take_five)

    element = @driver.find_element(:css, '.selectboxit-focus > .selectboxit-option-anchor')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText')
    @driver.action.move_to(element).release.perform
    @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItContainer').click
    @driver.execute_script("window.scrollTo(0,508)")

   ###  FILLED IN EMPLOYMENT DETAILS#

###########

   ##########################################
    #      INCOME & EXPENDITURE  - New page #
   ##########################################

    wait_for_window(take_five)
    @driver.find_element(:id, 'j_id0:idfrm:j_id4:j_id332').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:j_id244SelectBoxItText').click
    element = @driver.find_element(:css, '.selectboxit-option-last > .selectboxit-option-anchor')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:css, '.cp_agree_contacts__c_monthly_income__c')
    @driver.action.move_to(element).release.perform
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:j_id237').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idMonthlyIncome').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idMonthlyIncome').send_keys('2000')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idHousing').send_keys('500')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idUtilities').send_keys('80')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idEmplrMonthly').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idEmplrMonthly').send_keys('0')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idTransport').send_keys('80')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idOther').send_keys('120')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idPhone').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idPhone').send_keys('35')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idInsurance').send_keys('40')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idCreditCards').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idCreditCards').send_keys('200')
    @driver.switch_to.window @driver.window_handles.last
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idOtherLoan').send_keys('35')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idcarLoan').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idcarLoan').send_keys('0')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idTotalOther').send_keys('200')
    #@driver.find_element(:css, '.button--primary').click
    wait_for_window(take_five)
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:iddisposalinc').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:iddisposalinc').send_keys :clear
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:iddisposalinc').send_keys('0')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:iddisposalinc').click
    @driver.find_element(:css, '#idIncExpensePage\:idForm\:j_id6\:j_id345 > a.button.button--primary.push--top.push--left.disabledbutton').click

    ##########################


   ##########################################
    #     JOINT APPLICANT  - New page #
   ##########################################

   # Save Button

   @driver.find_element(:css, '#j_id0\:frm\:j_id2\:j_id231 > center > a.button.button--primary.push--top.push--left.disabledbutton').click

  ##########################################

    ##########################################
    #     Credit Proposal  - New page #
   ##########################################

   # Select a quote
   @driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:j_id394').click

   # Find and attach a quote
   @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:test').click

   # Generate PDF
   @driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:GeneratePDFButton').click
   @driver.switch_to.window(@driver.window_handles[2])
   @driver.current_url
   binding.pry
   #download_url()
   @driver.switch_to.window(@driver.window_handles[1])

   # Submit Proposal
   @driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:j_id969 > a').click

    @driver.find_element(:id, 'j_id0:frm:j_id2:j_id232').click
    @driver.find_element(:css, '.button--primary').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:Reason_ProposalSelectBoxItText').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:IdMainPanel').click
    element = @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description')
    @driver.action.move_to(element).perform
    element = @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description')
    @driver.action.move_to(element).release.perform
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description').send_keys('Ford Focus 1.8 S')
    element = @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:FINDAttachQuoteMain')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:css, '#IdPage\\3Aj_id1\\3Aj_id195\\3AIdPage\\3AIdForm\\3A actStatusId\\.start > #el_loading')
    @driver.action.move_to(element).release.perform
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:FINDAttachQuoteMain').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id528').click
    @driver.switch_to.window(@vars['root'])
    expect(@driver.switch_to.alert.text).to eq('This session will expire in five minutes. To remain connected and to prevent possible data loss, please validate this window.')
    @driver.switch_to.window(@vars['win7761'])
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:description').send_keys('Renault CLIO HATCHBACK 0.9 TCE 90 GT Line 5dr')
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id527').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costMonthlyRental').send_keys('250')
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costCapitalCost').send_keys('11500')
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:FINDAttachQuoteMain').click
    @driver.find_element(:css, '.card-row:nth-child(3) > .tab-one-fifth:nth-child(5) .small').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:Idquotesbox8:4:j_id499').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click
    @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:j_id516:IdNextPreviousNEXT').click

