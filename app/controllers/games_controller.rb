require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10).map{ ('A'..'Z').to_a.sample }
    @grid = @letters.join(' ')
  end

  def score
    @input = params[:letters]
    @grid = params[:grid]
    @final_score = new_score(@input, @grid)
  end

  def new_score(input, grid)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    dictionary_read = open(url).read
    dictionary_parsed = JSON.parse(dictionary_read)
    if dictionary_parsed["found"] && include?(input.upcase, grid)
      return "well done!"
    elsif dictionary_parsed["found"] && include?(input.upcase, grid) == false
      return "not in the grid :("
    else
      return "not an english word"
    end
  end

  def include?(word, grid)
    a = word.chars
    a.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

end
