class Player
  attr_accessor :hand
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
    self.hand = choice
    puts "You chose #{Game::CHOICES[hand]}."
  end
end

class Computer < Player

  def choose_hand
    self.hand = Game::CHOICES.keys.sample
    puts "Computer chose #{Game::CHOICES[hand]}."
  end
end

class Game
  attr_reader :player, :computer

  CHOICES = { 'R' => 'Rock', 'P' => 'Paper', 'S' => 'Scissors' }

  def initialize
    @player = Human.new("You")
    @computer = Computer.new("Computer")
  end

  def winner_message(winning_hand)
    if winning_hand == 'R'
      puts "Rock beats Scissors!"
    elsif winning_hand == 'P'
      puts "Paper wraps Rock!"
    elsif winning_hand == 'S'
      puts "Scissors cuts Paper!"
    end
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie"
    elsif player.hand == 'R' && computer.hand == 'S' \
      || player.hand == 'P' && computer.hand == 'R' \
      || player.hand == 'S' && computer.hand == 'P'
      winner_message(player.hand)
      puts "You won!"
    else
      winner_message(computer.hand)
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