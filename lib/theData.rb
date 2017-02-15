class TheData
  attr_accessor :all_categories, :category_link, :category, :post

  def initialize
    get_categories
  end

  def get_categories
    @all_categories = Scraper.scrape_categories.collect do |category|
      next if category.text == 'wiki' or category.text == 'gilded'
      {:name => category.text, :link => category['href']}
    end.compact
  end

  def select_category(selection)
    puts "category = #{selection[:link]}"
    @category_link = selection[:link]
  end

  def get_selected_category
    @category = Scraper.scrape_selected_category(@category_link).collect do |post|
      {:name => post.inner_text}
    end
  end

  def select_specific_post(selection)
    puts selection
  end
end
