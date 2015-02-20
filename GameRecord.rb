require 'sgf'

require_relative 'Estimator.rb'

class GameRecordList

  def initialize
    @list = []
    @parser = SGF::Parser.new
  end


  def add( sgfdata )
    data_tree = @parser.parse sgfdata
    @list.push GameRecord.new data_tree.games.first, sgfdata

  end

  def list
    @list
  end
end

class GameRecord

  def initialize( game, sgf )
    @game = game
    @sgf = sgf

    @estimate = nil
  end

  def get_data
    return @game
  end

  def estimate_result( rerun = false )
    if @game.result.slice(2, 6) != "Resign"
      @estimate = @game.result
    elsif @estimate.nil? || rerun
      @estimate = Estimator::estimate_result @sgf
    end

    @estimate
  end

  def conflicted_resign?
    if @game.result.slice(2, 6) == "Resign" and @game.result.slice(0,1) != estimate_result.slice(0,1)
      return true
    else
      return false
    end
  end

  def conflicted_resign_str
    if conflicted_resign?
      return "CONFLICTED RESIGN: resigned player (#{loser}) was winning by " + estimate_result.slice(2, 100)
    else
      return nil
    end
  end

  def loser
    if @game.result.slice(0,1) == "W"
      @game.black_player
    elsif @game.result.slice(0,1) == "B"
      @game.white_player
    else
      " ?? "
    end
  end

  def to_s
    str = 
    "#{@game.white_player} - #{@game.black_player}\n" +
    "\t#{@game.result} : #{estimate_result}" 

    if conflicted_resign?
      str += "\n\t#{conflicted_resign_str}"
    end

    str
  end
end
