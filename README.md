# kgs-sandbagger-estimator

This is a ruby script/program to analyze Go games from 
[KGS](http://gokgs.com) for possible 
[sandbagging](http://www.gokgs.com/help/faq/newbies.html#sandbagger) 
behaviour of a player.

**IMPORTANT!!**

The result given by this program is an **estimate** alert
that is not supposed to be taken at face value; rather, it is 
meant to be used to give rough estimate whether or not it is
worth it to look closer at a given player's games to decide 
whether the player is intentionally losing games to inflate 
his/her rank. Most importantly, it relies on a computer program 
(currently using GnuGO) to judge the "real" result of a game, 
which sets a limit to its reliability.

So, take its result with a grain of salt before accusing anyone.

## License

GPL version 2 or later. See LICENSE. Mostly because the program 
as it currently stands is rather dependent on GNUGo.

## Requrements 

* [GNUGo](https://www.gnu.org/software/gnugo/) installed (tested with 3.8)
* Ruby 1.9+ with following gems installed:
  * [rubyzip](https://github.com/rubyzip/rubyzip)

The program has been developed and tested on Ubuntu Linux 14.04.

## Usage instructions

Go to kgs archives page, search for player's games, download 
a month of a player's game in zip format. Save or move after 
save the zip into same directory than this program and run:

`$ ./estimate.rb <user>-<year>-<month>.zip`

