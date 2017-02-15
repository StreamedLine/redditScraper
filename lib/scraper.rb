class Scraper
  @@BasePath = "https://reddit.com"
  @@html = nil

  def self.scrape_categories
    @@html = Nokogiri::HTML(open(@@BasePath, 'User-Agent' => 'NoobyDooby'))
    category_list = @@html.css('#header ul.tabmenu li a')
  end

  def self.scrape_selected_category(link)
    puts "link = #{link}"
    @@html = Nokogiri::HTML(open(link, 'User-Agent' => 'NoobyDooby'))

    post_list = @@html.css('.thing.link')
  end
end
