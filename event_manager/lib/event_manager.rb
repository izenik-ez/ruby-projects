require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'


# The .to_s is for nil cases.
# nil.to_s => ""
# "".rjust(5,'0') => "00000"
def clean_zipcode(zipcode)  
  zipcode.to_s.rjust(5,'0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[^\d]/,'')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == "1"
    phone_number[1..10]
  else
      nil
  end  
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials

    #legislator_names = legislators.map do |legislator|
    #  legislator.name
    #end
  # legislator_names = legislators.map(&:name)
    #legislators_string = legislator_names.join(", ")
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  
  filename = "output/thanks_#{id}.html"
  
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end


def most_common_hour(contents)
  reg_hours = []  
  contents.each do |row|    
    reg_date = row[:regdate]    
    reg_hours << Time.strptime(reg_date, '%m/%d/%y %H:%M').hour
  end
  common_hour = reg_hours.reduce(Hash.new(0)) do |h, hour|
    h[hour] += 1
    h
  end

  common_hour.max_by{|k, v| v}[0]
  
end

def most_common_day(contents)
  reg_day = []

  contents.each do |row|
    reg_date = row[:regdate]
    reg_day << Time.strptime(reg_date, '%m/%d/%y %H:%M').strftime('%A')
  end
  common_day = reg_day.reduce(Hash.new(0)) do |h, day|
    h[day] += 1
    h
  end

  common_day.max_by{|k, v| v}[0]
end

puts "EventManager initialized."

contents = CSV.open('event_attendees.csv',
                    headers: true,
                    header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter




puts "\nThe most common hour of registration is: #{most_common_hour contents}:00"

contents.rewind
puts "\nThe most common registration day is: #{most_common_day contents}"
# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])

#   legislators = legislators_by_zipcode(zipcode)

#   form_letter = erb_template.result(binding)
#   phone = row[:homephone]
#   puts phone
  
#   puts "\nThe most common hour of registration is: #{most_common_hour}:00"
#   #save_thank_you_letter(id, form_letter)
# end
