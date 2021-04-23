contents = File.read("5desk.txt").split

# Randomly select word betwee 5 and 12 characters long

dictionary = contents.select {|word| word.length > 4 && word.length < 13}

word = dictionary.shuffle.first

puts "Word: #{word} - Length: #{word.length}"

# Game loop begins








# File.open('5desk.txt', 'r').each { |line| puts line}