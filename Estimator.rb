# This class runs sgf data against gnugo or, in future, some other 
# Go analyzing software.

require 'open3'

class Estimator

  def self.estimate_result( sgfdata = "" )

    # either "estimate" or "aftermath" or "finish"

    # NOTE1: "aftermath"/"finish" will be SLOW... gnugo will 
    # basically play against itself to the end of game!

    # NOTE2: "estimate" will yield values that differ from X.5
    # points due to the way gnugo works.

    # NOTE3: Sometimes, especially if there's lots of potentially 
    # unclaimed / unclear territory, estimate and aftermath 
    # can yield wildly differing results, including different
    # outcome of game.

    accuracy = "estimate"

    result = Open3.capture2e(
      "gnugo - --quiet --score #{accuracy}",
      :stdin_data=>sgfdata,
      :binmode=>true
    )

    if accuracy == "aftermath" || accuracy == "finish"
      s_arr = result.first.split("\n")[-3].split(" ")
    elsif accuracy == "estimate"
      s_arr = result.first.split(" ")
    else
      return "unknown accuracy in estimator!"
    end
    "#{s_arr[0][0]}+#{s_arr[3]}"
  end
end
