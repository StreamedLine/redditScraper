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
  end

  def list(array)
    array.each_with_index do |category, index|
      puts "#{index+1}. #{category[:name]}"
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
end