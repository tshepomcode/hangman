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
  puts "Enter letter (a-z) to guess word or 'q' to quit game"
  puts 'last turn' if turn == 8
end

def player_input
  input = gets.chomp
  return input if input.match(/[a-z]/) && input.length == 1
  return input if input.downcase =='q'

  
  puts 'Your guess should be a single character between a - z'

  player_input

end

instructions

word = get_word.downcase

puts "Word: #{word} - Length: #{word.length}"

# Print hangman word

(word.length).times { |w| print "_"}
puts
puts

turn = 1
found_chars = []
wrong_chars = []
guess_letters = []
locations = []


while turn <= 8
  # display some sort of count so the player knows how many more incorrect 
  # guesses they have before the game ends
  puts "Turn: #{turn} of 8"
  turn_messages(turn)

  guess = player_input
  guess_letters << guess

  word_arr = word.chars

  puts "word_arr  = #{word_arr}"
  
  # puts guess


  # You should also display which correct letters have already been chosen
  if word_arr.any?(guess)
    puts "We found something"
    found_chars << guess
    locations = word_arr.each_index.select { |index| word_arr[index] == guess}
    puts "locations = #{locations}"
  else
    puts "Wrong guess"

  end
  find_correct = word_arr.find_all { |i| i == guess}

  puts "find_correct = #{find_correct}"
  puts "found_chars = #{found_chars}"
  
  # and their position in the word, e.g. _ r o g r a _ _ i n g) 
  # and which incorrect letters have already been chosen.


  turn += 1
  break if guess.downcase == 'q'


end










# File.open('5desk.txt', 'r').each { |line| puts line}