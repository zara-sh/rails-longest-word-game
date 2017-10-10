class PagesController < ApplicationController
  def game
  end

  def score
    # byebug
    start_time = Time.parse params[:start_time]
    @run_game = run_game(params[:word], params[:grid], start_time, Time.now)
    # @grid = params[:grid]
  end

  def grid
    @generate_grid = generate_grid(params[:num].to_i)
    @start_time = Time.new
  end

  private

  require 'open-uri'
  require 'json'
  # becarfule about 1- json is all captilize,
  # 2- dont use captalize you var
  # 3- if you var is green so there is sth wrong
  # 4-
  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    alphabet = ("A".."Z").to_a
    grid = []
    grid_size.times { grid.push(alphabet[rand(1...alphabet.length)]) }
    grid
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result
    site = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    dict = JSON.parse(site)
    msg = { notEnglish: "not an english word", notInGrid: "not in the grid", wellDone: "well done"
    }
     attempt_array = attempt.upcase.split("")
    condition = attempt_array.all? { |elem| attempt_array.count(elem) <= grid.count(elem) }
    time_taken = end_time - start_time
    #byebug
    score_t = attempt.length * 10 - time_taken
    if dict["found"] == false
      p" This is not an english word 0"

      return { time: time_taken, score: 0, message: msg[:notEnglish] }
    elsif condition == false
      puts "This was not in the grid 0 "
       return { time: time_taken, score: 0, message: msg[:notInGrid] }
    else
      puts " All good #{score_t}"
      return { time: time_taken, score: score_t, message: msg[:wellDone] }
    end
  end




end
