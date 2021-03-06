class Cli
  attr_accessor :theData
  
  def initialize
    @theData = TheData.new
  end

  def run
    get_categories
    select_categories

    get_selected_category
    select_specific_post

    display_post
  end

  def list(array)
    array.each_with_index do |category, index|
      if index.even? 
        puts "#{index+1}. #{category[:name]}".colorize(:background => :red, :color => :white) 
      else 
        puts "#{index+1}. #{category[:name]}".colorize(:background => :light_black, :color => :white)
      end
    end 
  end
  
  def get_categories
    @theData.get_categories
  end

  def select_categories
    list(@theData.all_categories)
    selection = nil
    while !selection or selection == "" or !selection.to_i.between?(1, @theData.all_categories.count)
      puts "please select a category"
      selection = gets.chomp
      if selection.upcase == 'LIST'
        list(@theData.all_categories)
        selection = nil
        next
      elsif selection.upcase == 'Q'
        exit
      end
    end
    @theData.select_category(@theData.all_categories[selection.to_i-1])
  end

  def get_selected_category
    @theData.get_selected_category
  end

  def select_specific_post
    list(@theData.category)
    selection = nil
    while !selection or selection == "" or !selection.to_i.between?(1, @theData.category.count)
      puts "please select a post"
      selection = gets.chomp
      if selection.upcase == 'LIST'
        list(@theData.category)
        selection = nil
        next
      elsif selection.upcase == 'Q'
        exit
      end
    end
    @theData.select_specific_post(@theData.category[selection.to_i-1])
  end

  def display_post
    puts "\n#{"Title:".colorize(:color => :light_white)} #{@theData.post[:title].colorize(:color => :light_green)}"
    puts "#{"Author:".colorize(:color => :light_white)} #{@theData.post[:author].colorize(:color => :green)}"
    puts "#{"Posted on:".colorize(:color => :light_white)} #{@theData.post[:time].colorize(:color => :yellow)}"
    puts "#{"Link:".colorize(:color => :light_white)} #{@theData.post[:link].colorize(:color => :light_blue)}"
    puts ""
    display_in_browser
  end

  def display_in_browser
    link = @theData.post[:link]
    puts "Type b to display in browser or any key to quit".colorize(:color => :cyan)
    browser = STDIN.gets.chomp
    if browser.upcase == 'B'
      begin
         Launchy.open(link)
      rescue
        puts "Couldn't access browser. Link will be copied to clipboard instead.".colorize(:red)
        Clipboard.copy(link)
        puts "#{link.colorize(:light_blue)} copied to cliboard!"
      end
    end
  end
end