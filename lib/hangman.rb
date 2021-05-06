def get_word
  contents = File.read("5desk.txt").split
  # Randomly select word betwee 5 and 12 characters long
  
  dictionary = contents.select {|word| word.length > 4 && word.length < 13}
  
  word = dictionary.shuffle.first

  return word
end

def instructions
  instructions = <<-HOW

  How to play Hangman

  Hangman is a quick and easy game you play agains the computer.
  The computer makes up a secret word, while you , the  
  player tries to guess the word by asking what letters it contains.
  However, every wrong guess brings you one step closer to losing.

  HOW

  puts instructions
end

def turn_messages(turn)
  puts "\tEnter letter (a-z) to guess word" if turn == 1
  puts "\tEnter 0 to quit the game" if turn == 1
  puts "\tEnter 1 to save" if turn == 1
  puts
  puts 'last turn' if turn == 12
end

def player_input
  input = gets.chomp
  return input if input.match(/[a-z0-1]/) && input.length == 1
  # return input if input.downcase =='1'

  
  puts 'Your guess should be a single character between a - z'

  player_input

end

def display_letters(word_arr, found_chars, wrong_chars, complete)
  found = []
  # puts '------ In the display_letters method ------'
  # puts "word_arr = #{word_arr} | found_chars = #{found_chars}"
  # puts "wrong_chars = #{wrong_chars} | locations = #{locations}"

  found_chars.each do |c|
    found << word_arr.each_index.select { |index| word_arr[index] == c}
  end

  puts "found = #{found}"
  flat_found = found.flatten.sort
  puts "flat_found = #{flat_found}"


  word_arr.each_with_index do | letter, index |
    if flat_found.include?(index)
      print letter
    else
      print '_'
    end
  end

  if word_arr.length == found.flatten.length
    puts
    # puts "Lengths are the same !!!"
    # puts "word_arr = #{word_arr} | flat_found = #{found.flatten}"

    word_arr.each_with_index do | l, i|
      if flat_found.include?(i)
        complete << l
      end
    end
    # puts "complete = #{complete}"
  end
    # puts word_arr.each_index.select { |index| word_arr[index] == guess}
  # found.each do |pos|

  # end
  puts "\n"
  print "Incorrect guesses: "
  puts "\n"
  wrong_chars.each {|w| print w }
  puts
  # puts '------ end of display_letters method ------'
end

def save_file(turn, word_arr, guess)
  File.open("save.txt", "w") { |f| f.write "#{Time.now},#{turn},#{word_arr},#{guess}" }
  puts "File Saved!"

  guess = player_input
  return if guess != '1'

  save_file(turn, word_arr, guess) if guess == '1'
  
end

instructions

word = get_word.downcase

# Print hangman word
puts "Word: #{word} - Length: #{word.length}"

(word.length).times { |w| print "_"}
puts
puts

turn = 1
found_chars = []
wrong_chars = []
guess_letters = []
locations = []
flat_found = []
complete = []

while turn <= 12
  # display some sort of count so the player knows how many more incorrect 
  # guesses they have before the game ends
  puts "Turn: #{turn} of 12"
  turn_messages(turn)
  word_arr = word.chars
  
  guess = player_input
  
  break if guess.downcase == '0'

  if guess == '1'
    save_file(turn, word_arr, guess)
    guess = player_input
  end

  # load_file if guess == 2
  guess_letters << guess #if guess.match(/[a-z]/)
  
  # puts "guess_letters = #{guess_letters.sort}"
  # puts "word_arr  = #{word_arr.sort}"
  
  # puts guess

  # You should also display which correct letters have already been chosen
  if word_arr.any?(guess)
    # puts "We found something"
    found_chars << guess
    locations << word_arr.each_index.select { |index| word_arr[index] == guess}
    # puts "locations = #{locations}"
    # disply correct letters
  else
    puts "Wrong guess"
    wrong_chars << guess
    # puts
    # wrong_chars.each {|w| print w }
    puts
  end

  display_letters(word_arr, found_chars, wrong_chars, complete)
  puts

  # puts "complete in main  : #{complete}"
  # puts "word_arr in main : #{word_arr}"
  if complete.eql?(word_arr)
    puts "YOu Win! Well Done!"
    break
  end

  find_correct = word_arr.find_all { |i| i == guess}

  # puts "find_correct = #{find_correct}"
  # puts "found_chars = #{found_chars}"

  
  # and their position in the word, e.g. _ r o g r a _ _ i n g) 
  # and which incorrect letters have already been chosen.

  turn += 1

end










# File.open('5desk.txt', 'r').each { |line| puts line}