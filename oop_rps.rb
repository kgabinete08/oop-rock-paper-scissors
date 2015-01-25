class Player
  attr_accessor :selection
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Human < Player

  def choose_hand
    begin
      puts "Please choose one: Rock(R), Paper(P) or Scissors(S)"
      choice = gets.chomp.upcase
    end until Game::CHOICES.keys.include?(choice)
    self.selection = choice
    puts "You chose #{Game::CHOICES[selection]}."
  end
end

class Computer < Player

  def choose_hand
    self.selection = Game::CHOICES.keys.sample
    puts "Computer chose #{Game::CHOICES[selection]}."
  end
end

class Game
  attr_reader :player, :computer

  CHOICES = { 'R' => 'Rock', 'P' => 'Paper', 'S' => 'Scissors' }

  def initialize
    @player = Human.new("You")
    @computer = Computer.new("Computer")
  end

  def winner_message(selection)
    if selection == 'R'
      puts "Rock beats Scissors!"
    elsif selection == 'P'
      puts "Paper wraps Rock!"
    elsif selection == 'S'
      puts "Scissors cuts Paper!"
    end
  end

  def compare_hands
    if player.selection == computer.selection
      puts "It's a tie"
    elsif player.selection == 'R' && computer.selection == 'S' \
      || player.selection == 'P' && computer.selection == 'R' \
      || player.selection == 'S' && computer.selection == 'P'
      winner_message(player.selection)
      puts "You won!"
    else
      winner_message(computer.selection)
      puts "Computer won!"
    end
  end

  def play
    loop do
      player.choose_hand
      computer.choose_hand
      compare_hands

      begin
        puts "Would you like to play again? (Y/N)"
        new_game = gets.chomp.upcase
      end until new_game == 'Y' or new_game ==  'N'
      break if new_game == 'N'
    end
  end
end

Game.new.play