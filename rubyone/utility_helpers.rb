# frozen_string_literal: true

 class UtilityHelpers
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
      
      def wait_until_disappears(long_press_on_coordinates_with_duration, name)
        wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
        wait.until { !@driver.find_element(locator, name).displayed? }
      end

      def wait_until_disabled(long_press_on_coordinates_with_duration, name)
        wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
        wait.until { !@driver.find_element(locator, name).enabled? }
      end

      def wait_until_element_is_enabled(driver, type, name)
        wait = Selenium::WebDriver::Wait.new(:timeout => 15) # seconds
        wait.until { driver.find_element(type => name).enabled? }
      end
 end