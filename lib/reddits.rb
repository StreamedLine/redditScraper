require_relative "reddits/version.rb"
require "open-uri"
require "nokogiri"
require "pry"

require_relative "./cli.rb"
require_relative "./theData.rb"
require_relative "./scraper.rb"

Cli.new.run

module Reddits
  # Your code goes here...
end
