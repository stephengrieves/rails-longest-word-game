require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    match = @word.chars.all? { |letter| @word.count(letter) <= @letters.chars.count(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    valid_word = JSON.parse(URI.open(url).read)
    if match == true && (valid_word['found'] == true)
      message = "Congratulations #{params[:word]} is a valid English word!"
    elsif valid_word == false && test == true
      message = "Sorry but #{params[:word]} does not seem to be a valid English word"
    elsif match == false
      message = "Sorry but #{params[:word]} can't be build out of #{params[:letters]}"
    end
    @result = message
  end
end
