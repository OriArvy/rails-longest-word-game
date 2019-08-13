require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split("")
    if english? && in_grid?
      @answer = "Congratulations! #{@word} is a valid English word!"
    elsif english? && in_grid? == false
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"
    else
      @answer = "Sorry #{@word} is not a valid English word"
    end
  end

  private

  def english?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    return user['found']
  end

  def in_grid?
    @letters = params[:letters]
    @word = params[:word]
    @word.chars.all? do |char|
      @word.count(char) <= @letters.count(char)
    end
  end
end
