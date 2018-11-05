require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # display a new random grid and a form
    @letters = Array.new(10) { [*"A".."Z"].sample }
    # binding.pry
  end

  def score
    # The form will be submitted with POST) to the score action
    @letters = params[:hidden_letters]
    @letter_array = @letters.split(",")
    @player_input = params[:answer_input]

    @result = []
    if is_not_subset
      @result = is_not_subset
    else
      @result = parse_result
    end
  end

  private

  def is_not_subset
    @player_input_array = @player_input.upcase.split("")

    grid_char_frequency = Hash.new(0)
    @letter_array.each { |letter| grid_char_frequency[letter] += 1 }
    # raise
    @player_input_array.each do |character|
      return "A given character is not in the grid." unless grid_char_frequency.include?(character)
      return "The #{character} character has not sufficient repetitions in the grid." if grid_char_frequency[character].zero?
      grid_char_frequency[character] -= 1
    end

    return false
  end

  def parse_result
    url = "https://wagon-dictionary.herokuapp.com/#{@player_input}"

    words = JSON.parse(open(url).read)

    if words['found'] == false
      message = "not an english word"
      score = 0
    elsif words['found']
      score = words['length'] ** 2
      message = "Congratulations! Your score is #{score}. Well done!"
    end

    return message
  end
end
