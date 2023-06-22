require_relative './helper.rb'
require 'bundler'
Bundler.require

Selenium::WebDriver::Chrome::Service.driver_path = './chromedriver'
## uncomment to keep window opened after script finishes
caps = Selenium::WebDriver::Remote::Capabilities.chrome("goog:chromeOptions" => {detach: true})
driver = Selenium::WebDriver.for :chrome#, :capabilities => [caps]
session = GoogleDrive::Session.from_service_account_key('client_secret.json')

google_sheet_name = 'Template refresh Feb 2022'
gid = 577028770
work = 'generic_work'
url = "https://samvera:hyku@mola.bl-staging.notch8.cloud/concern/#{work}s/new?locale=en"
starting_row = 4

spreadsheet = session.spreadsheet_by_title(google_sheet_name)
worksheet = spreadsheet.worksheet_by_gid(gid.to_s)
rows = worksheet.rows[starting_row-1..-1]
matched_rows = []
not_found_rows = []
did_not_match_rows = []


# driver.manage.window.maximize
driver.get(url)
driver.find_element(:xpath, '//a[@href="/users/sign_in?locale=en"]').click
driver.find_element(:id, 'user_email').send_keys('')
driver.find_element(:id, 'user_password').send_keys('')
driver.find_element(:name, 'commit').click

# rows[73..73].each do |row|
#   label = row[col('a')]
#   puts label
#   text = driver.find_element(
#     :xpath, "//label[contains(text(), '#{label}')]/following-sibling::p"
#   ).text
#   puts text
# end

# exit

rows.each do |row|
  label = row[col('a')]
  google_sheets_entry = row[col('o')]
  webpage_output = label_check(driver, label)

  if webpage_output == google_sheets_entry
    matched_rows << row
    rows.delete(row)
  end
end

## chooses Organisational from dropdown
dropdown = driver.find_element(:id, "#{work}_creator_group__creator_name_type")
choose = Selenium::WebDriver::Support::Select.new(dropdown)
choose.select_by(:text, "Organisational")

rows.each do |row|
  label = row[col('a')]
  google_sheets_entry = row[col('o')]
  webpage_output = label_check(driver, label)

  if webpage_output == google_sheets_entry
    matched_rows << row
  elsif webpage_output == "'#{label}' not found".red
    not_found_rows << row
  else
    did_not_match_rows << row
  end
end

matched_rows.each do |row|
  label = row[col('a')]
  google_sheets_entry = row[col('o')]
  webpage_output = label_check(driver, label)
  puts "✅ '#{label}' matches".green,
    "Help text: #{google_sheets_entry}\n\n"
end

not_found_rows.each do |row|
  label = row[col('a')]
  google_sheets_output = row[col('o')]
  webpage_output = label_check(driver, label)
  puts "❓ '#{label}' help text not found".yellow,
    "Should say: #{google_sheets_output}\n\n"
end

did_not_match_rows.each do |row|
  label = row[col('a')]
  google_sheets_output = row[col('o')]
  webpage_output = label_check(driver, label)
  puts "❌ '#{label}' does not match".red,
    "Should say: #{google_sheets_output}",
    "Instead says: #{webpage_output}\n\n"
end

puts "Matched: #{matched_rows.length}".green,
  "Not found: #{not_found_rows.length}".yellow,
  "Did not match: #{did_not_match_rows.length}".red,
  "------------------",
  "Total: #{matched_rows.length + not_found_rows.length + did_not_match_rows.length}\n".blue
