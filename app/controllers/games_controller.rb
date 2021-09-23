require 'open-uri'
require 'json'

class GamesController < ApplicationController
    
    def new
        @letters = ('a'..'z').to_a.shuffle[1..10].join
        session[:user_score]
    end

    def score
        @word = params[:word]
        @possible_letters = params[:possible_letters]
        @word.split("").each do |x|
          if @possible_letters.include?(x.downcase) && valid_word?(@word)
            session[:user_score] =  session[:user_score] + @word.size
            return @answer = "Congratulations! #{@word.upcase} is a valid English word!"
          elsif @possible_letters.include?(x.downcase)
            return @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word!"
          else
            return @answer = "Sorry but #{@word.upcase} can't be build out of #{@possible_letters.upcase.split("").join(", ")}"
          end
        end
    end
end

private

def valid_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
end

