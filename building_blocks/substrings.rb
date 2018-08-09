=begin
Implement a method #substrings that takes a word as the first argument and
then an array of valid substrings (your dictionary) as the second argument. 
It should return a hash listing each substring (case insensitive) that was found
in the original string and how many times it was found.
=end
   
def substrings(str, dictionary)
    matches = Hash.new(0)
    dictionary.each do |word|
        matches[word] = str.downcase.scan(/#{word}/).count
    end
    puts matches
  end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("I go below, then down and further down. Then I sit down and say howdy partner - howdy.", dictionary)


