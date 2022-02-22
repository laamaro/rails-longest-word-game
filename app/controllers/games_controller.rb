require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    # binding.pry
    # raise
    if include?
      if english_word?
        @result = "Congratulations! #{params[:word]} is a valid english word"
      else
        @result = "Sorry, but #{params[:word]} is not an eglish word!"
      end
    else
      @result = "Sorry, but #{params[:word]} can't be built out of #{@letters}"
    end
  end

  def include?
    @letters = params[:letter].split
    @word_letters = params[:word].upcase
    @word_letters.chars.all? { |letter| @word_letters.count(letter) <= @letters.count(letter) }
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
