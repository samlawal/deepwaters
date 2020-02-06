require "rubygems"
require "selenium-webdriver"
require "pry"
require "rspec"
require "open-uri"

# require "http"
# require 'openssl'
# require 'nokogiri'

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
    always_open_pdf_externally: true,
  },
  download: {
    prompt_for_download: false,
    directory_upgrade: true,
    default_directory: "/testdata",
  },
}
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument("--ignore-certificate-errors")
options.add_argument("--disable-popup-blocking")
options.add_argument("--disable-translate")
options.add_argument("start-maximized")
# options.add_argument("--incognito")

options.add_preference(:download, prefs)

#@driver = Selenium::WebDriver.for :chrome
@driver = Selenium::WebDriver.for :chrome, options: options

@driver.manage.delete_all_cookies # seconds
@driver.manage.timeouts.page_load = 30 # seconds
@driver.manage.timeouts.implicit_wait = 30 # seconds

@wait = Selenium::WebDriver::Wait.new(:timeout => 4) # seconds
@user_exists = false

def wait_for_element(tag, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 3) # seconds
  begin
    # wait.until { @driver.find_element(tag,  element)
    wait.until { driver.find_element(tag, element).displayed? }
    wait.until { driver.find_element(tag, element).enabled? }
  rescue
    puts "Waited out for 30 sec #{tag} #{element}"
  end
end

def download_url
  get_url = @driver.current_url
  #get_url_parse = URI.parse(get_url).open(:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
  #download = open(get_url_parse,  :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] )
  #doc = Nokogiri::HTML(open(url, :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] ))
  download = open(get_url)
  # IO.copy_stream(download, "~/testdata/my_file.pdf")
  IO.copy_stream(download, "~/my_file.pdf")
end

def wait_for_window(timeout = 2)
  #sleep(round(timeout / 1000))
  sleep(timeout / 1000)
  wh_now = @driver.window_handles
  wh_then = @vars["window_handles"]
  wh_now.find { |window| window != wh_then.first }
rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def wait_for_element_by_id(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:id, element) }
  ensure
    #driver.quit
  end
end

def wait_for_element_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 1) # seconds
  wait.until { driver.find_element(:link_text, element) }
rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def wait_for_element_to_be_enabled_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:link_text, element).displayed? }
    wait.until { driver.find_element(:link_text, element).enabled? }
  ensure
    #driver.quit
  end
end

def wait_until_element_appears(driver, locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  wait.until { driver.find_element(locator, name).displayed? }
rescue
  #driver.quit
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

def is_element_enabled(driver, locator, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 20) #
  begin
    #element = wait.until { driver.find_element(:id => element).enabled? }
    wait.until { driver.find_element(locator, element).enabled? }
  ensure
    #driver.quit
  end
end

def wait_until_disappears(locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
  wait.until { !@driver.find_element(locator, name).displayed? }
rescue
  puts "Could not find #{locator} #{name}"
end

def wait_until_disabled(locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
  wait.until { !@driver.find_element(locator, name).enabled? }
rescue
  puts "Could not find #{locator} #{name}"
end

def wait_until_element_is_enabled(driver, type, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
  wait.until { driver.find_element(type => name).enabled? }
rescue
  puts "Could not find #{locator} #{name}"
end

def download_url
  get_url = @driver.current_url
  #get_url_parse = URI.parse(get_url).open(:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
  #download = open(get_url_parse,  :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] )
  #doc = Nokogiri::HTML(open(url, :http_basic_authentication => ['Damien.fortune@autorama.co.uk', 'Autorama1'] ))
  download = open(get_url)
  # IO.copy_stream(download, "~/testdata/my_file.pdf")
  IO.copy_stream(download, "~/my_file.pdf")
end

@vars = {}
$take_five = 1000
$bool_contract_found = false

def wait_for_window(timeout = 2)
  #sleep(round(timeout / 1000))
  sleep(timeout / 1000)
  wh_now = @driver.window_handles
  wh_then = @vars["window_handles"]
  wh_now.find { |window| window != wh_then.first }
rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def wait_for_element_by_id(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:id, element) }
  ensure
    #driver.quit
  end
end

def wait_for_element_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 1) # seconds
  wait.until { driver.find_element(:link_text, element) }
rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def wait_for_element_to_be_enabled_by_link(driver, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  begin
    wait.until { driver.find_element(:link_text, element).displayed? }
    wait.until { driver.find_element(:link_text, element).enabled? }
  ensure
    #driver.quit
  end
end

def wait_until_element_appears(locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
  wait.until { @driver.find_element(locator, name).displayed? }
rescue
  puts "element did not appear #{locator} #{name}"
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

def is_element_enabled(driver, locator, element) #timeout = 2
  wait = Selenium::WebDriver::Wait.new(:timeout => 20) #
  begin
    #element = wait.until { driver.find_element(:id => element).enabled? }
    wait.until { driver.find_element(locator, element).enabled? }
  ensure
    #driver.quit
  end
end

def wait_til_element_disappears(locator, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  wait.until { !@driver.find_element(locator, name).displayed? }
rescue
  puts "Could not find #{locator} #{name}"
end

def wait_til_element_is_enabled(type, name)
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  wait.until { @driver.find_element(type => name).enabled? }
rescue
  puts "Could not find #{locator} #{name}"
end

@driver.get("https://brokers.leaseplan.co.uk/login.asp?")
@driver.manage.window.maximize
#binding.pry
@driver.find_element(:id, "txtuserNameWPQ1_DOCQ1").click
@driver.find_element(:id, "txtuserNameWPQ1_DOCQ1").send_keys("Damien.fortune@autorama.co.uk")
@driver.find_element(:id, "txtpassWordWPQ1_DOCQ1").click
@driver.find_element(:id, "txtpassWordWPQ1_DOCQ1").send_keys("Autorama1")
@driver.find_element(:id, "txtpassWordWPQ1_DOCQ1").send_keys(:enter)

def switch_to_window_with_text(target)
  index = 0
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
  index = 0
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
  wait = Selenium::WebDriver::Wait.new(:timeout => 7) # seconds
  # page_state = browser.execute_script('return document.readyState;')
  # ajax_state = browser.execute_script('return jQuery.active == 0')

  # spin_state = browser.execute_script("return $('.spinner').is(':visible') == false")

  wait.until {
    #  return page_state == "complete"
    return (browser.execute_script("return document.readyState;") && browser.execute_script("return jQuery.active == 0")) #   && spin_state)
  }
  puts "page_has_loaded #{return}"
end

def page_ajax_has_finished(browser)
  @wait.until { browser.execute_script("return jQuery.active == 0") }
end

#Rotate through selection to see if any match
def quote_select(driver, contractTypeValue)

  #$bool_contract_found = false

  puts " Current state of Contract Search #{$bool_contract_found}"
  w = 0
  until $bool_contract_found
    puts "Enter into the next 5 choices available"

    x = 1
    y = 5
    z = 0

    while x <= y
      xpath = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:IdQuotesBoxSectionOnly']/div/div[1]/div[#{x}]/div/div/a/span"
      xpath_rel_cont = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:IdQuotesBoxSectionOnly']/div/div[7]/div[#{x}]/div/div[1]"
      xpath_rel_quote = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:IdQuotesBoxSectionOnly']/div/div[1]/div[#{x}]/div/div/a/span"
      xpath_rel_sel = "//*[@id='dPage:j_id1:j_id195:IdPage:IdForm:Idquoßesbox8:#{z}:j_id499']"
      xpath_rel_sel_1 = "//*[@id='dPage:j_id1:j_id195:IdPage:IdForm:Idquoßesbox8:#{z}:j_id499']"
      xpath_rel_sel_2 = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:Idquotesbox8:#{z}:IdselectedQuoteRepeat1']"
      xpath_rel_sel_att_1 = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:attacgButtonRepeat']"
      xpath_rel_sel_att_2 = "//*[@id='IdPage:j_id1:j_id195:IdPage:IdForm:attacgButtonRepeat']"

      ###########

      print x, ". Ruby while loop.\n"
      # wait_for_window($take_five)
      wait_for_window($take_five)
      is_element_present(:xpath, xpath_rel_cont)
      link_has_gone_stale(:xpath, xpath_rel_cont)
      contractType = driver.find_element(:xpath, xpath_rel_cont).text
      puts "got contractType value of #{contractType}"

      if contractType == contractTypeValue
        # Click on Select
        sequenceID = driver.find_element(:xpath, xpath_rel_quote).text
        puts "Gotcha! sequenceID value of #{sequenceID}"

        $bool_contract_found = true
        puts "Found contractType value of #{sequenceID} : #{$bool_contract_found}"

        if w != 0
          xpath_rel_sel = xpath_rel_sel_2
          xpath_rel_sel_att = xpath_rel_sel_att_2
        end
        driver.find_element(:xpath, xpath_rel_sel).click
        driver.find_element(:xpath, xpath_rel_sel_att).click

        break
      end
      x += 1
      z += 1
    end

    puts "bool_contract_found #{$bool_contract_found}"

    if $bool_contract_found == false
      # Click next 5 if the conditions are not met and we have completed 5 iterations
      puts "Couldn't find #{contractType}. Please go the next 5 options : bool_contract_found #{$bool_contract_found}"

      wait_for_window($take_five)
      # wait_for_window($take_five)
      driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:j_id864:IdNextPreviousAllNEXT").click
      wait_for_window($take_five)
    end
    print w, ". Ruby w until loop.\n"

    w += 1
  end
end

def accept_cookies(driver)
  testcon = driver.find_element(:css, ".accept-cookies-button")
  if (testcon.displayed?)
    testcon.click
  end
rescue StandardError => e
  puts "Rescued: #{e.inspect}"
end

def switch_handles()
  @vars["window_handles"] = @driver.window_handles
  @vars["win7761"] = wait_for_window(2000)
  @vars["root"] = @driver.window_handle
  @driver.switch_to.window(@vars["win7761"])
end

def is_element_present(how, what)
  result = @driver.find_elements(how, what).size() > 0
  if result
    result = @driver.find_element(how, what).displayed? && @driver.find_element(how, what).enabled?
    puts "Results displayed #{result} : #{how} : #{what} "
  end
  @driver.manage.timeouts.implicit_wait = 10
  return result
end

def link_has_gone_stale(how, what)
  begin
    # poll the link with an arbitrary call
    @driver.find_element(how, what)
    return false
    puts "Active Element Found"
  rescue
    return true
    puts "StaleElementReferenceError encountered"
  end
end

def wait_and_click(tag, prop)
  # wait_for_ajax
  link_has_gone_stale(tag, prop)
  element = @wait.until {
    tmp_element = @driver.find_element(tag, prop)
    if tmp_element.enabled? && tmp_element.displayed?
      puts " Inside Wait and Click #{prop} "

      is_disabled = !tmp_element.attribute("disabled")

      if is_disabled
        puts " Should be clickable#{prop} "
        element = tmp_element
      end
    end
  }
  element.click
rescue => e
  puts "Couldn't click on element:  #{e.inspect} "
end

wait_for_window($take_five)
page_has_loaded(@driver)
#@driver.find_element(:css, '.ap-login-action span').click

accept_cookies(@driver)

@vars["window_handles"] = @driver.window_handles
@driver.find_element(:link_text, "NeMO").click
@vars["win7761"] = wait_for_window(2000)
@vars["root"] = @driver.window_handle
@driver.switch_to.window(@vars["win7761"])
wait_for_window($take_five)
@driver.execute_script("window.scrollTo(0,213.3333282470703)")

if is_element_present(:id, "j_id0:idform:j_id3:j_id103")
  @driver.find_element(:id, "j_id0:idform:j_id3:j_id103").click
end

wait_til_element_is_enabled(:link_text, "ACCEPT")
@driver.execute_script("markQuestionAgree(0)")
@driver.execute_script("markQuestionAgree(1)")
@driver.execute_script("markQuestionAgree(2)")

@driver.find_element(:link_text, "SELECT").click
page_has_loaded(@driver)
wait_for_window($take_five)

# Customer details - NEW PAGE

wait_for_window($take_five)
wait_until_element_appears_by_id(@driver, "j_id0:form:j_id5:Idfirstname")
@driver.find_element(:id, "j_id0:form:j_id5:Idfirstname").click
@driver.find_element(:id, "j_id0:form:j_id5:Idfirstname").send_keys("Liam")
@driver.find_element(:name, "j_id0:form:j_id5:j_id314").click
@driver.find_element(:name, "j_id0:form:j_id5:j_id314").send_keys("Meehan8")

# @driver.find_element(:name, "j_id0:form:j_id5:j_id314").send_keys("Meehan6")
# @driver.find_element(:name, "j_id0:form:j_id5:j_id314").send_keys("Meehan5")
@driver.find_element(:id, "j_id0:form:j_id5:idDay").click
@driver.find_element(:id, "j_id0:form:j_id5:idDay").send_keys("17")
@driver.find_element(:id, "j_id0:form:j_id5:idMonth").click
@driver.find_element(:id, "j_id0:form:j_id5:idMonth").send_keys("02")
@driver.find_element(:id, "j_id0:form:j_id5:idYear").click
@driver.find_element(:id, "j_id0:form:j_id5:idYear").send_keys("1994")
@driver.find_element(:id, "j_id0:form:j_id5:idPostCode").click
@driver.find_element(:id, "j_id0:form:j_id5:idPostCode").send_keys("hp2 7bw")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode1").click
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode1").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode2").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode3").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode4").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode5").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idSortCode6").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idACode1").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idACode2").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idACode3").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idACode4").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idACode5").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idACode6").send_keys("1")
@driver.find_element(:id, "j_id0:form:j_id5:idACode7").send_keys("0")
@driver.find_element(:id, "j_id0:form:j_id5:idACode8").send_keys("1")
element = @driver.find_element(:css, ".button")
@driver.action.move_to(element).click_and_hold.perform
element = @driver.find_element(:css, ".button")
@driver.action.move_to(element).perform
element = @driver.find_element(:css, ".button")
@driver.action.move_to(element).release.perform
wait_for_window($take_five)

wait_and_click(:css, ".button")
#@driver.find_element(:css, ".button").click
@driver.execute_script("window.scrollTo(0,1248)")
wait_for_window($take_five)

#####
#New functionality

# //*[@id="j_id0:form:j_id5:j_id422"]/a

if is_element_present(:css, '#j_id0\:form\:j_id5\:j_id421 > a')
  @user_exists = false
  wait_and_click(:css, '#j_id0\:form\:j_id5\:j_id421 > a')
else
  @user_exists = true
end

wait_and_click(:css, ".walkme-custom-balloon-button-text")

#############################

########
# CUSTOMER DETAILS > Customer Identity

#  Click on the TITLE
wait_for_element(:css, ".button:nth-child(2)")
@driver.find_element(:css, ".button:nth-child(2)").click
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id279SelectBoxItText").click
# element = @driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id279SelectBoxItContainer > div')
@driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Prof']").click

#  Click on RESIDENTIAL STATUS
element = @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id310SelectBoxItText")
element.click
@driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Owned mortgaged']").click

# MARITAL STATUS
#  SELECT MARITAL STATUS
element = @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id316SelectBoxItText")
element.click
@driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Married']").click

#Number of dependents
element = @driver.find_element(:xpath, '//*[@id="idPageConsumer:idForm:j_id13:j_id319"]/fieldset/input')
element.click
element.send_keys :backspace
element.send_keys("4")

#signatory direct debit
# wait_for_window($take_five)
wait_for_element_by_id(@driver, "idPageConsumer:idForm:j_id13:checkbox1")
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:checkbox1").click

################################################
#############################
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth").click
2.times { @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth").send_keys :backspace }
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressMonth").send_keys("12")

2.times { @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressYear").send_keys :backspace }
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:idAddressYear").send_keys("2014")
############################################

# Check to see if addresss field is already pre-populated

# town
element = @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:county__c")
county_text = element.attribute("value")
puts "user exist #{@user_exists}  and county_text #{county_text}"
puts "user exist #{@user_exists} "
if @user_exists == false && county_text.to_s.empty?
  # Selecting Address
  puts "Selecting Address"

  wait_for_window($take_five)

  @driver.switch_to.window @driver.window_handles.last

  is_element_present(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:InvokeRapidSearchButtonId0")
  # @driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:InvokeRapidSearchButtonId0").click
  wait_and_click(:id, "idPageConsumer:idForm:j_id13:j_id461:j_id462:j_id465:0:InvokeRapidSearchButtonId0")
  page_has_loaded(@driver)

  # handleSubmit();

  wait_for_window(2000)
  @driver.switch_to.frame(2)
  @driver.switch_to.frame(0)
  @driver.find_element(:id, "ButtonSearch").click
  @driver.find_element(:id, "ButtonSearch").send_keys :enter
  # binding.pry

  wait_for_window($take_five)
  # @driver.switch_to.frame('rapidSearch')
  @driver.find_element(:id, "searchText").send_keys("Nationwide")

  wait_for_window($take_five)

  @driver.find_element(:id, "ButtonSearch").click
  # @driver.find_element(:id, 'ButtonSearch').send_keys :enter

  wait_for_window($take_five)
  # binding.pry
  # @driver.switch_to.frame(2)
  # @driver.switch_to.frame(0)
  @driver.find_element(:id, "Accept").click
else
  puts "frame doesn't exist"
end
# switch_handles()
# wait_for_window($take_five)
@driver.switch_to.default_content

#@driver.find_element(:css, '.address__c_to__c').click
wait_for_window($take_five)
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:j_id650").click
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:mainphone").click
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:mainphone").send_keys :clear
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:mainphone").send_keys("02071234567")
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:idemail").click

@driver.find_element(:id, "idPageConsumer:idForm:j_id13:idmobilephonenumber").click
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:idmobilephonenumber").send_keys :clear
@driver.find_element(:id, "idPageConsumer:idForm:j_id13:idmobilephonenumber").send_keys("07123456789")

# Sometimes text exist, so check first before entering data
is_element_present(:id, "idPageConsumer:idForm:j_id13:idemail")
box_present = @driver.find_element(:id, "idPageConsumer:idForm:j_id13:idemail").attribute("value")

if box_present.to_s.empty? && @user_exists == false
  @driver.find_element(:id, "idPageConsumer:idForm:j_id13:idemail").click
  @driver.find_element(:id, "idPageConsumer:idForm:j_id13:idemail").send_keys :clear
  @driver.find_element(:id, "idPageConsumer:idForm:j_id13:idemail").send_keys("lian.meehan8@autorama.co.uk")

  # @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idemail').send_keys('lian.meehan6@autorama.co.uk')
  # @driver.find_element(:id, 'idPageConsumer:idForm:j_id13:idemail').send_keys('lian.meehan5@autorama.co.uk')

end

# SAVE AND CONTINUE
@driver.find_element(:css, '#idPageConsumer\:idForm\:j_id13\:j_id651 > button').click

#########################################
#      BANK ACCOUNT DETAILS  - New page #
##########################################
# Agree
if !$user_exists
  wait_and_click(:link_text, "AGREE")
  wait_until_element_appears(:xpath, "//*[@type='submit' and @value='AGREED' and @disabled='disabled']")

  # wait_for_window($take_five)

  # binding.pry
  if is_element_present(:link_text, "AGREE")
    @driver.find_element(:link_text, "AGREE").click
    wait_until_element_appears(:xpath, "//*[@type='submit' and @value='AGREED' and @disabled='disabled']")
  end
  #click on next button

  wait_and_click(:css, ".walkme-custom-balloon-title")

  # wait_for_window($take_five)

  #  if @driver.find_element(:css, '.walkme-custom-balloon-title').displayed?
  #   @driver.find_element(:css, '.walkme-custom-balloon-title').click
  #   @driver.find_element(:css, '.walkme-custom-balloon-button-text').click
  #  end
  # wait_and_click(:css, '.walkme-custom-balloon-title')
  wait_and_click(:css, ".walkme-custom-balloon-button-text")

  if is_element_present(:link_text, "AGREE")
    @driver.find_element(:link_text, "AGREE").click
    wait_until_element_appears(:xpath, "//*[@type='submit' and @value='AGREED' and @disabled='disabled']")
  end

  @driver.execute_script("window.scrollTo(0,-500.333333492279053)")

  # confirm
  if is_element_present(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a')
    @driver.execute_script("$('.HideAllButtonnew').hide(); markQuestionAgree(2);progressStatus();")
    # @driver.find_element(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a').click
  else
    puts "Cannot confirm element is present"
  end

  # save and continue

  wait_for_element_by_id(@driver, "j_id0:idfrm:j_id8:j_id332")
  # onclick="A4J.AJAX.Submit('j_id0:idfrm',event,{'similarityGroupingId':'j_id0:idfrm:j_id8:j_id331','parameters':{'j_id0:idfrm:j_id8:j_id331':'j_id0:idfrm:j_id8:j_id331'} ,'status':'j_id0:actStatusId'} );return false;"
  @driver.find_element(:id, "j_id0:idfrm:j_id8:j_id332").click
  wait_til_element_disappears(:id, "j_id0:idfrm:j_id8:j_id332")

  page_has_loaded(@driver)

  ##########################################
  #      EMPLOYMENT DETAILS  - New page #
  ##########################################
  @driver.execute_script("window.scrollTo(0,500.333333492279053)")
  #wait_for_window($take_five)
  #####
  # Confirm
  ####

  if is_element_present(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")

    # wait_and_click(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText')
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:selectSelectBoxItText').click

    ###  FILLED IN EMPLOYMENT DETAILS#
    ###########
    # Occupation
    #else

    element = @driver.find_element(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")
    element.click
    wait_and_click(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Military']")
    # @driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Military']").click
  end

  if is_element_present(:name, "j_id0:idfrm:j_id4:j_id246")
    element = @driver.find_element(:name, "j_id0:idfrm:j_id4:j_id246")
    profile_text = element.attribute("value")
    puts "user exist #{@user_exists}  and profile_text #{profile_text}"
    # @driver.find_element(:name, 'j_id0:idfrm:j_id4:j_id246').click
    # @driver.find_element(:name, 'j_id0:idfrm:j_id4:j_id246').send_keys('Senior Customer Credit Specialist')

  elsif is_element_present(:xpath, "//*[@id='j_id0:idfrm:j_id4:j_id242']/fieldset/input")
    element = @driver.find_element(:xpath, "//*[@id='j_id0:idfrm:j_id4:j_id242']/fieldset/input")
    profile_text = element.attribute("value")
    puts "user exist #{@user_exists}  and profile_text #{profile_text}"
    # @driver.find_element(:xpath, "//*[@id='j_id0:idfrm:j_id4:j_id242']/fieldset/input").click
    # @driver.find_element(:xpath, "//*[@id='j_id0:idfrm:j_id4:j_id242']/fieldset/input").send_keys('Senior Customer Credit Specialist')
  end

  if profile_text.to_s.empty?
    element.click
    element.send_keys("Senior Customer Credit Specialist")
    @driver.find_element(:id, "j_id0:idfrm:j_id4:j_id253").click
    @driver.find_element(:id, "j_id0:idfrm:j_id4:j_id253").send_keys("Autorama UK Ltd")

    element = @driver.find_element(:id, "j_id0:idfrm:j_id4:county__c")
    county_text = element.attribute("value")
    puts "user exist #{@user_exists}  and county_text #{county_text}"
    puts "user exist #{@user_exists} "

    if county_text.to_s.empty?
      @driver.find_element(:id, "j_id0:idfrm:j_id4:postcode__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:postcode__c").send_keys("HP2 7DE")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:house_name__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:house_name__c").send_keys("Vanarama")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:street__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:street__c").send_keys("Marylands Avenue")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:town__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:town__c").send_keys("Hemel Hempstead")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:idPostCode").send_keys("hp2 7de")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:county__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:county__c").send_keys("Hertfordshire")
      @driver.find_element(:id, "j_id0:idfrm:j_id4:country__c").click
      @driver.find_element(:id, "j_id0:idfrm:j_id4:country__c").send_keys("United Kingdom")
    end
  end
  #end
  # Confirm
  # wait_for_window($take_five)

  # wait_for_element(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a')

  if is_element_present(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a')
    @driver.find_element(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a').click
    wait_until_disabled(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a')
  end

  # Save and Continue
  # binding.pry

  if is_element_present(:id, "j_id0:idfrm:j_id4:j_id332")
    jscript_save_cont = "A4J.AJAX.Submit('j_id0:idfrm',event,{'similarityGroupingId':'j_id0:idfrm:j_id4:j_id332','oncomplete':function(request,event,data){Restyle_select_box(true);edqInitialize();},'parameters':{'j_id0:idfrm:j_id4:j_id332':'j_id0:idfrm:j_id4:j_id332'} ,'status':'j_id0:idfrm:actStatusId'} );return false;"
    # wait_and_click(:id, 'j_id0:idfrm:j_id4:j_id332')
    @driver.execute_script(jscript_save_cont)

    wait_til_element_disappears(:css, '#j_id0\:idfrm\:j_id8\:j_id312\:2\:j_id318 > a')

    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:j_id332').click
  elsif is_element_present(:id, "j_id0:idfrm:j_id8:j_id332")
    # @driver.find_element(:id, 'j_id0:idfrm:j_id8:j_id332').click
    wait_and_click(:id, "j_id0:idfrm:j_id8:j_id332")
    wait_til_element_disappears(:id, "j_id0:idfrm:j_id8:j_id332")

    #@driver.execute_script("4J.AJAX.Submit('j_id0:idfrm',event,{'similarityGroupingId':'j_id0:idfrm:j_id8:j_id332','parameters':{'j_id0:idfrm:j_id8:j_id332':'j_id0:idfrm:j_id8:j_id332'} ,'status':'j_id0:actStatusId'} );return false;")
  else
    puts "Cannot Click on Save and Continue"
  end
end
# binding.pry
page_has_loaded(@driver)

wait_for_element(:id, "idIncExpensePage:idForm:j_id6:j_id244SelectBoxItText")

# Save and Continue
@driver.execute_script("window.scrollTo(0,500.3333282470703)")
# Occupation
if is_element_present(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")
  element = @driver.find_element(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")
  occupation_text = element.attribute("value")
  puts "user exist #{@user_exists}  and occupation_text #{occupation_text}"
  if occupation_text.to_s.empty?
    wait_til_element_is_enabled(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")
    element = @driver.find_element(:id, "j_id0:idfrm:j_id4:selectSelectBoxItText")
    element.click
    wait_and_click(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Military']")
    # @driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Military']").click
  end

  if is_element_present(:id, "j_id0:idfrm:j_id4:j_id332")
    wait_and_click(:id, "j_id0:idfrm:j_id4:j_id332")
    # @driver.find_element(:id, 'j_id0:idfrm:j_id4:j_id332').click
  else is_element_present(:id, "j_id0:idfrm:j_id8:j_id332")
    
 # @driver.find_element(:id, 'j_id0:idfrm:j_id8:j_id332').click
    wait_and_click(:id, "j_id0:idfrm:j_id8:j_id332")   end
  # @driver.action.move_to(element).release.perform
  # @driver.find_element(:id, "j_id0:idfrm:j_id4:selectSelectBoxItContainer").click
end
##########################################
#      INCOME & EXPENDITURE  - New page #
##########################################

if is_element_present(:id, "idIncExpensePage:idForm:j_id6:j_id244SelectBoxItText")
  @driver.find_element(:id, "idIncExpensePage:idForm:j_id6:j_id244SelectBoxItText").click
  wait_and_click(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Household']")
  # @driver.find_element(:xpath, "//a[@class='selectboxit-option-anchor' and text()='Household']").click
end

@driver.execute_script("window.scrollTo(0,508)")
wait_for_window($take_five)
is_element_present(:id, "idIncExpensePage:idForm:j_id6:j_id237")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:j_id237").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idMonthlyIncome").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idMonthlyIncome").send_keys("2000")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idHousing").send_keys("500")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idUtilities").send_keys("80")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idEmplrMonthly").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idEmplrMonthly").send_keys("0")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idTransport").send_keys("80")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idOther").send_keys("120")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idPhone").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idPhone").send_keys("35")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idInsurance").send_keys("40")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idCreditCards").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idCreditCards").send_keys("200")
@driver.switch_to.window @driver.window_handles.last
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idOtherLoan").send_keys("35")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idcarLoan").click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idcarLoan").send_keys("0")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:idTotalOther").send_keys("200")
wait_and_click(:css, ".button--primary")
# @driver.find_element(:css, '.button--primary').click
is_element_present(:id, "idIncExpensePage:idForm:j_id6:iddisposalinc")
wait_and_click(:id, "idIncExpensePage:idForm:j_id6:iddisposalinc")
# @driver.find_element(:id, 'idIncExpensePage:idForm:j_id6:iddisposalinc').click
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:iddisposalinc").send_keys :clear
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:iddisposalinc").send_keys("0")
@driver.find_element(:id, "idIncExpensePage:idForm:j_id6:iddisposalinc").click
@driver.find_element(:css, '#idIncExpensePage\:idForm\:j_id6\:j_id345 > a.button.button--primary.push--top.push--left.disabledbutton').click

##########################

##########################################
#     JOINT APPLICANT  - New page #
##########################################
# binding.pry
# Save Button
page_has_loaded(@driver)
is_element_present(:css, '#j_id0\:frm\:j_id2\:j_id231')
@driver.find_element(:css, '#j_id0\:frm\:j_id2\:j_id231 > center > a.button.button--primary.push--top.push--left.disabledbutton').click
##########################################

##########################################
#     Credit Proposal  - New page #
##########################################
# Request funding #
@driver.execute_script("window.scrollTo(0,708)")

#  Enter Description
wait_til_element_is_enabled(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:wtable\:0\:description')
@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:wtable\:0\:description').click
@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:wtable\:0\:description').send_keys("Test ")

# MAXIMUM MONTHLY RENTAL
@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costMonthlyRental").click
4.times { @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costMonthlyRental").send_keys :backspace }

@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costMonthlyRental").send_keys("500.00")

# MAXIMUM CAPITAL LEND
@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costCapitalCost").click
4.times { @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costCapitalCost").send_keys :backspace }
@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costCapitalCost").send_keys("50000.00")
@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:costCapitalCost").send_keys :tab

# Select a quote
################
#Select all
wait_for_window($take_five)
is_element_present(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:j_id394")
# wait_and_click(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:j_id394')
@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:j_id394').click

wait_for_window($take_five)

# Find and attach a quote
is_element_present(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:test")
# wait_and_click(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:test")
@driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:test").click

# # Total Cost Descending
# @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:SearchTotalCostDescending').click
quote_select(@driver, "Personal Contract Hire")

######## Update text area with correct car description
# Extract make of car
wait_for_window($take_five)
car_make = @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:descriptionModel").text
puts "got car_make value of #{car_make}"
# Extract build and specify
car_model = @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:descriptionQuotes").text
puts "got car_model value of #{car_model}"

# Paste into text description area

@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:wtable\:0\:description').click
@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:wtable\:0\:description').send_keys("#{car_make} #{car_model}")

# # Total Cost Descending, By Id
# @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:SearchTotalCostDescending').click
# @driver.find_element(:id, 'IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:SearchById').click

# # Search for the right type of qupte  - Personal Contract Hire

# binding.pry
# # Select option
# @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:wtable:0:Idquotesbox8:0:j_id499").click

# # Select all quote
# @driver.find_element(:id, "IdPage:j_id1:j_id195:IdPage:IdForm:test").click

# Generate PDF
is_element_present(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:GeneratePDFButton')
@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:GeneratePDFButton').click
wait_for_window($take_five)

# @driver.switch_to.window(@driver.window_handles[2])
# wait_for_window($take_five)

# @driver.current_url
@driver.execute_script("window.scrollTo(0,-248)")
binding.pry
# @driver.save_screenshot("testpdf.jpg")
# # binding.pry
# #download_url()
# @driver.switch_to.window(@driver.window_handles[1])

# Submit Proposal
# @driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:j_id969 > a').click

# Confirm submission sucess
#@driver.find_element(:css, '#IdPage\:j_id1\:j_id195\:IdPage\:IdForm\:j_id281 > a').click
