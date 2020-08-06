require 'watir'
require 'webdrivers'
require 'nokogiri'

namespace :scrape do
  desc "Scrape an index page of a city at slicelife.com"
  task slicelife_index: :environment do
    # 
    browser = Watir::Browser.new

    browser.goto('https://slicelife.com/shop/search?search_shipping_type_filter=either&address=San%20Francisco,%20CA,%20USA')

    puts browser.title
    js_doc  = browser.div(class: /_8mjm61/).wait_until(&:present?)

    # puts js_doc.inner_html
    @doc     = Nokogiri::HTML.parse(js_doc.inner_html)
    puts "### Search for nodes by css"
    # good_stuff =  doc.at_css('div._8mjm61')
    # links_parent = @doc.css('._8mjm61')
    links_fragment = @doc.css('._1j8jxoz').first
    puts links_fragment
    puts "======"
    shops = []
    @doc.css('._1j8jxoz').each do |link|
        puts "found link"
        link_href = link.attributes["href"].value.to_s
        img_src = link.css('._19wyhi7').css('img').attr('src').value.to_s
        location_name = link.css('._1pkohes').css('p._1e3rlyy').text.to_s.strip
        location_rating_and_no_reviews = link.css('._1pkohes').css('._1ezh8s1').text
        location_rating = location_rating_and_no_reviews.split("(").first.to_f
        no_reviews = location_rating_and_no_reviews.split("(").last.to_i
        address = link.css('._1pkohes').css('._4qdonk').text.to_s
        order_minimum = link.css('._a9pofd').css('p._1nje18l')[0].text.split("-").first.gsub(/[^\d\.]/, '').to_f
        wait_time = link.css('._a9pofd').css('p._1nje18l')[1].text
        min_wait_time = wait_time.split("-").first.strip.to_i
        max_wait_time = wait_time.split("-").last.strip.to_i
        delivery = link.css('._a9pofd').css('p._1nje18l')[2].text.to_s.gsub(/[^\d\.]/, '').to_f
        
        shop_hash = {link_href: link_href, img_src: img_src, location_name: location_name, location_rating: location_rating, no_reviews: no_reviews, order_minimum: order_minimum, wait_time: wait_time, min_wait_time: min_wait_time, max_wait_time: max_wait_time, delivery: delivery}
        shop = OpenStruct.new(shop_hash)
        shops << shop
        # puts wait_time
        # puts delivery
    end
    puts shops
    puts "Stats count: #{shops.length}, class: #{shops.class}"

    # puts all_html

    browser.close

    # 
  end
end
