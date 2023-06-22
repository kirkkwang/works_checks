## click on image with class
# driver.find_element(:class, "tenant-logo").click

## click on link with text
# driver.find_element(:link_text,'Contact').click
# driver.find_element(:link_text,'Works').click

## click on link with href
# driver.find_element(:xpath,'//a[@href="/users/sign_in?locale=en"]').click

## wait for element to appear
# wait = Selenium::WebDriver::Wait.new(:timeout => 2)
# wait.until{driver.find_element(:link_text, 'Dashboard').click}

## click on sign in through xpath
# driver.find_element(:xpath,'//a[@href="/users/sign_in?locale=en"]').click

## log in
# driver.find_element(:id, 'user_email').send_keys('support@notch8.com')
# driver.find_element(:id, 'user_password').send_keys('testing123')
# driver.find_element(:name, 'commit').click

## returns page source
# p driver.page_source

## log into main page
# driver.get('https://samvera:hyku@mola.bl-staging.notch8.cloud/')

## reset current page source to current url
# driver.get(driver.current_url)

## finding by xpath with 'and'
# driver.find_element(:xpath, '//input[@type="radio" and @value="Article"]').click

## running windowless mode
# https://sqa.stackexchange.com/questions/2609/running-webdriver-without-opening-actual-browser-window

## maximize window
# driver.manage.window.maximize
