require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'


def clean_zipcode(zipcode)
  (zipcode || "").rjust(5, '0')[0..4]
end

def clean_number(number)
  number = number || ""
  number.gsub!(/[^0-9]/, '')

  number = 
    if number.length == 10
      "(#{number[0..2]}) #{number[3..5]}-#{number[6..]}"        
    elsif number.length == 11 && number[0] == "1"
      clean_number(number[1..])
    else
      "Invalid number"
    end

  number
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody', ]
      ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end

end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') { |file| file.puts form_letter}
end


  
puts "Event Manager Initialized\n\n"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]

  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  number = clean_number(row[:homephone])

  regdate = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  reg_hour = regdate.hour
  reg_day = Date::DAYNAMES[regdate.wday]

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  puts "#{reg_day} at #{reg_hour}"

end

