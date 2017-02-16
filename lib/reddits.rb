require_relative "reddits/version.rb"
require "open-uri"
require "nokogiri"
require "colorize"
require "pry"

require_relative "./cli.rb"
require_relative "./theData.rb"
require_relative "./scraper.rb"

def reddits
  Cli.new.run
end

module Reddits
  # Your code goes here...
end
