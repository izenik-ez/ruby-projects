require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'


# The .to_s is for nil cases.
# nil.to_s => ""
# "".rjust(5,'0') => "00000"
def clean_zipcode(zipcode)  
  zipcode.to_s.rjust(5,'0')[0..4]
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



puts "EventManager initialized."

contents = CSV.open('event_attendees.csv',
                    headers: true,
                    header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

def clean_zipcode_old(zipcode)
  if zipcode.nil?
    '00000'
  elsif zipcode.length < 5
    zipcode.rjust(5,'0')
  elsif zipcode.length > 5
    zipcode[0..4]
  else
    zipcode
  end
end



contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end
