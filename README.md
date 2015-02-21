# sandbagger-estimator

This is a ruby script/program to analyze zip archives of Go games 
(for example from [KGS archives](http://www.gokgs.com/archives.jsp)) for possible 
[sandbagging](http://www.gokgs.com/help/faq/newbies.html#sandbagger) 
behaviour of a player.

This software or its original author have not been any way endorsed 
or sponsored or authorized by KGS or any other go playing service.

The author(s) of this software may or may not have or have had 
an user account at any go playing service.

**IMPORTANT!!**

The result given by this program is an **estimate** alert
that is not supposed to be taken at face value; rather, it is 
meant to be used to give rough estimate whether or not it is
worth it to look closer at a given player's games to decide 
whether the player is intentionally losing games to deflate
his/her rank. Most importantly, it relies on a computer program 
(currently using GNUGo) to judge the "real" result of a game, 
which sets a limit to its reliability.

So, take its result with a grain of salt before accusing anyone.
And look how the suspicious games actually look like.

Also, miscalculations happen. People do sometimes see their 
status incorrectly, especially on close games and resign.
This tool is supposed to give some quick overview of 
_tendencies_. Never judge anyone based on only one or even 
few suspiciously "lost" games!

And again: computer program is not a judge.

## What it does:

It reads a zip file for sgf files and prints the official result 
and estimate result from GNUGo for each game, comparing especially 
resigned games to the estimated result.

It does NOT look into time losses in any way except print them
out, so it kind of "misses" those if they indeed are intentional
losses.

## License

GPL version 2 or later. See LICENSE. Mostly because the program 
as it currently stands is rather dependent on GNUGo.

## Requrements 

* [GNUGo](https://www.gnu.org/software/gnugo/) installed (tested with 3.8)
* Ruby 1.9+ with following gems installed:
  * [SgfParser](https://github.com/Trevoke/SGFParser)
  * [rubyzip](https://github.com/rubyzip/rubyzip)
* Bundler to help with gem installation

This program has been developed and tested on Ubuntu Linux 14.04. I don't
expect it to be too hard to get to work on OS X. For Windows... I really
don't know.

## Install instructions

Make sure GNUGo is installed and in your path. You can test if this 
is so by opening a terminal and simply writing `gnugo --version`.

Clone this repo and run `bundle install` within. You may need to 
run `gem install bundler` or even `sudo gem install bundler` 
first. Or do something else to get those gems to install and 
be available for this program.

## Usage instructions

Go to (for example) kgs archives page, search for player's games, 
download a month of a player's game in zip format. Then run:

`$ ./estimate.rb /path/to/file.zip`

The estimator uses GNUGo; the default choice for estimation is 
the same as running `gnugo file.sgf --score estimate` on every resigned 
game. To change the scoring option to "aftermath" or "finish" 
(See [GNUGo documentation](http://www.gnu.org/software/gnugo/gnugo_3.html#SEC37) 
for details) you need to edit Estimator.rb for now.

## Wishlist

There are already many things I want to make better, when time permits:

* Try to parallelize those score estimations
* Nicer outputs... Maybe output a html page with nice styles?
* Some player stats, especially "losses" : "conflicted resignations" ratio per player
* Make some heuristics for suspicious time losses as well
* Generalize inputs, make it accept a directory having sgf files as input and traverse that recursively
* Make it accept command-line argument to set the estimator accuracy option or some sane config file
* Maybe save the inputted games and estimations into a sqlite3 database? Use some hash algo to make sure every game is there only once.
  * This way we can save lots of time on slow score estimations. Sqlite3 because it's by far the easiest to integrate into this kind of program.
  * This will allow the software to start growing into general-purpose game archive, maybe a real ui with wxwidgets or something too?
