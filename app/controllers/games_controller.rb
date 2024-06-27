require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = create_random_letters(10)
  end

  def score
    # raise
    @result = set_result_text(params[:word], params[:letters])
  end

  def set_result_text(word, grid)
    if !in_grid?(word, grid)
      "Sorry, <span class=\"fw-bold fs-4\">#{word}</span> is not in the grid..."
    elsif !valid_word?(word)
      "<span class=\"fw-bold fs-4\">#{word}</span> is not a valid word mate..."
    else
      "You did it, <span class=\"fw-bold fs-4\">#{word}</span> was a great choice! Good job!"
    end
  end

  def valid_word?(word)
    html_content = URI.open("https://dictionary.lewagon.com/#{word}").read
    parsed_info = JSON.parse(html_content)
    # puts parsed_info
    parsed_info["found"]
  end

  def in_grid?(word, grid)
    result = true
    word.chars.each do |letter|
      result = false if word.count(letter) > grid.count(letter)
    end
    result
  end

  def create_random_letters(amount)
    numbers_array = []
    amount.times do
      numbers_array << ("a".."z").to_a.sample
    end
    numbers_array
  end
end
