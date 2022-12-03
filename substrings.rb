def count_substrings (string, substring)
  count = string.scan(substring).length
  if count != 0
    { string: substring, count: count }
  else
    nil
  end
end

#puts "#{count_substrings "below", "low"}"

def substrings (string, dictionary)
  hash = Hash.new(0)
  dictionary.each do |dict|
    match = count_substrings string, dict
    hash << match if match
  end
end
