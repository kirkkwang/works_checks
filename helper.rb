# turns the string found in google sheets into a snake case string
def snake str
  str.downcase.gsub(/\s+/, '_').gsub(/-/, '_').delete('?')
end

# turns column letter into number
def col str
  offset = 'A'.ord - 1
  str.upcase!.chars.inject(0) { |x,c| x*26 + c.ord - offset } - 1
end

# checks if the label is found on the page and returns the help text or not found
def label_check driver, label
  begin
    begin
      begin
        text = driver.find_element(
          :xpath, "//label[contains(text(), '#{label}')]/following-sibling::p"
        ).text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        text = driver.find_element(
          :xpath, "//label[contains(text(), '#{label}')]/following-sibling::input"
        ).attribute('placeholder')
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
      text = driver.find_element(
        :xpath, "//label[contains(text(), '#{label}')]/following-sibling::select/option"
      ).text
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError
    "'#{label}' not found".red
  else
    text
  end
end

def find_column_by_value worksheet, work
  worksheet.rows[1..1].first.each_with_index do |v,c|
    return c.to_i if snake(v) == work
  end
end