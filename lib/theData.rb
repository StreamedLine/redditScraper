class TheData
  attr_accessor :all_categories, :category_link, :category, :post

  def initialize
    @post = {}
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
      {:name => post.css('div.entry').inner_text.split('submitted')[0], :post => post}
    end
  end

  def select_specific_post(selection)
    add_post_attributes(selection)
  end

  def add_post_attributes(selection)
    selection = selection[:post]
    @post[:title] = selection.css('a.title').text
    @post[:author] = selection.css('a.author').text
    @post[:link] = selection.css('a.title')[0]['href']
    @post[:time] = "#{selection.css('time')[0]['title']}; #{selection.css('time')[0].inner_text}"

    if @post[:link][0] == '/'
      @post[:link] = "https://reddit.com" + @post[:link]
    end
  end
end
