#!/usr/bin/ruby1.9.1

require 'rubygems'
require 'zip'
require_relative 'GameRecord.rb'

if ARGV.length < 1
  puts "Usage: ./estimate.rb <file.zip>"
  exit
end

zipfile_name = ARGV[0];

records = GameRecordList.new

Zip::File.open(zipfile_name) do |zip_file|

  zip_file.each do |game_record|
    if game_record.name.split(".").last == "sgf"
      records.add game_record.get_input_stream.read
    end
  end
end

records.list.each do |game|
  puts game
end
