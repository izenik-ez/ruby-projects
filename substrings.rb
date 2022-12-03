def substrings (string, dictionary)
  hash = Hash.new(0)
  dictionary.each do |dict|
    matches = string.downcase.scan(dict.downcase).length
    hash[dict] += matches if matches != 0
  end
  hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)

