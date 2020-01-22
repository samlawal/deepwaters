require 'rubygems'
require 'selenium-webdriver'
require 'pry'
require 'rspec'

prefs = {
  plugins: {
    plugins_disabled: ['Chrome PDF Viewer']
  },
  download: {
    prompt_for_download: false,
    directory_upgrade:   true,
    default_directory:   'desired/download/path'
  }
}

browser = Selenium::WebDriver.for :chrome, prefs: prefs

    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.delete_all_cookies # seconds
    @driver.manage.timeouts.implicit_wait = 30 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds


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
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:id => element).displayed? }
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

  #binding.pry
    #@driver.find_element(:css, '.ap-login-action span').click
    #@driver.find_element(:css, '.hamburger__label').click
    #@driver.find_element(:link_text, 'NeMO').click

# @driver.find_element(:id, 'wpq7_docq1_mainmenu___myfleetnetworkcommcentrecouk_documents_modules_menuitems_networkportal_nemo').click
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
    wait_for_window(take_five)

    # @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id272').click
    # @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:checkbox1').click
    # @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:InvokeRapidSearchButtonId0').click

    # wait_for_window(2000)
    # @driver.switch_to.frame(2)
    # @driver.switch_to.frame(0)
    # @driver.find_element(:id, 'ButtonSearch').click
    # @driver.find_element(:id, 'ButtonSearch').send_keys :enter

    # wait_for_window(take_five)
    # @driver.switch_to.frame(0)
    # @driver.find_element(:css, 'tr:nth-child(2) div').click
    # wait_for_window(take_five)
    # @driver.switch_to.frame(2)
    # @driver.switch_to.frame(0)
    # @driver.find_element(:id, 'Accept').click

    switch_handles()
    wait_for_window(take_five)
    #@driver.switch_to.default_content
    #@driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id461\:j_id462\:j_id465\:0\:j_id473 > button').click

#############################

  #   wait_for_window(take_five)
  #   @driver.switch_to.default_content
  #   @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id461\:j_id462\:j_id465\:0\:postcode__c').click
  #   binding.pry
  #   @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id461\:j_id462\:j_id465\:0\:postcode__c').send_keys('hp2 7de') #7de
  #   @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id461\:j_id462\:j_id465\:0\:InvokeRapidSearchButtonId0').click

  #  ##########
  #  wait_for_window(2000)
  #  @driver.switch_to.window @driver.window_handles.last
  #  @driver.switch_to.frame(3)
  #  @driver.switch_to.frame(0)

  #  @driver.find_element(:id, 'ButtonSearch').click #
  #  @driver.find_element(:id, 'ButtonSearch').send_keys :enter

  #  wait_for_window(take_five)
  #  @driver.switch_to.frame(0)

  #  @driver.find_element(:css, 'tr:nth-child(1) div').click
  #  wait_for_window(take_five)
  #  @driver.switch_to.frame(3)
  #  @driver.switch_to.frame(0)
  #  @driver.find_element(:id, 'Accept').click

  #   switch_handles()
  #   wait_for_window(take_five)

  #   @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth').click
  #   @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth').send_keys :clear
  #   @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth').send_keys('12')

  #   @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressYear').send_keys :clear
  #   @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressYear').send_keys('2014')
  #   @driver.execute_script("window.scrollTo(0,435.3333435058594)")
  #   wait_for_window(take_five)

########

    #@driver.find_element(:css, '.address__c_to__c').click
    wait_for_window(take_five)
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:j_id650').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').send_keys :clear
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:mainphone').send_keys('02071234567')
    #@driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').click
    #@driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys :clear
    #@driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys('071234567')
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idemail').click
    #@driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idemail').send_keys('lian.meehan@autorama.co.uk')
    #@driver.find_element(:css, '.button:nth-child(2)').click
    #wait_for_window(take_five)
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').click
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys :clear
    @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idmobilephonenumber').send_keys('07123456789')
    @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id651 > button').click

     #########################################
    #      BANK ACCOUNT DETAILS  - New page #
    ##########################################

    wait_for_window(take_five)
    @driver.find_element(:link_text, 'AGREE').click
    @driver.find_element(:id, 'j_id0:idfrm:j_id8:j_id332').click

   ##########################################
    #      EMPLOYMENT DETAILS  - New page #
   ##########################################
    @driver.execute_script("window.scrollTo(0,5.333333492279053)")
    @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText').click
    element = @driver.find_element(:css, '.selectboxit-focus > .selectboxit-option-anchor')
    @driver.action.move_to(element).click_and_hold.perform
    element = @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText')
    @driver.action.move_to(element).release.perform
    @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItContainer').click
    @driver.execute_script("window.scrollTo(0,508)")
    # @driver.find_element(:name, 'j_id0:idfrm:j_id4:j_id246').click
    # @driver.find_element(:name, 'j_id0:idfrm:j_id4:j_id246').send_keys('Senior Customer Credit Specialist')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:j_id253').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:j_id253').send_keys('Autorama UK Ltd')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:postcode__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:postcode__c').send_keys('HP2 7DE')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:InvokeRapidSearchButtonId0').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:InvokeRapidSearchButtonId0').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:InvokeRapidSearchButtonId0').click
    # @driver.find_element(:css, 'html').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:postcode__c').send_keys('HP2 7DE')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:house_name__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:house_name__c').send_keys('Vanarama')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:street__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:street__c').send_keys('Marylands Avenue')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:town__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:town__c').send_keys('Hemel Hempstead')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:idPostCode').send_keys('hp2 5de')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:county__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:county__c').send_keys('Hertforshire')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:country__c').click
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:country__c').send_keys('United Kingdom')

   ###  FILLED IN EMPLOYMENT DETAILS#

###########

    #wait_for_window(take_five)
    #@driver.find_element(:css, '.button:nth-child(2)').click




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
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idOtherLoan').send_keys('35')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idcarLoan').click
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idcarLoan').send_keys('0')
    @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:idTotalOther').send_keys('200')
    @driver.find_element(:css, '.button--primary').click
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

   binding.pry

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

