require 'nokogiri'
class Slicelife::PageParser::Search
    def initialize(fragment: fragment)
        @fragment = fragment
    end

    def parse
        shops = []
        @fragment.css('._1j8jxoz').each do |link|
            puts "found link"
            link_href = link.attributes["href"].value.to_s
            img_src = link.css('._19wyhi7').css('img').attr('src').value.to_s
            location_name = link.css('._1pkohes').css('p._1e3rlyy').text.to_s.strip
            location_rating_and_no_reviews = link.css('._1pkohes').css('._1ezh8s1').text
            location_rating = location_rating_and_no_reviews.split("(").first.to_f
            no_reviews = location_rating_and_no_reviews.split("(").last.to_i
            address = link.css('._1pkohes').css('._4qdonk').text.to_s
            # order_minimum = link.css('._a9pofd').css('p._1nje18l')[0].text#.split("-").first.gsub(/[^\d\.]/, '').to_f
            shop_stats = _get_shop_stats(link)
            # puts shop_stats
            
            shop_hash = {link_href: link_href, img_src: img_src, location_name: location_name, location_rating: location_rating, no_reviews: no_reviews, address: address}
            # puts shop_hash
            shop = shop_hash.merge(shop_stats) #OpenStruct.new(shop_hash)
            shops << shop
        end
        # puts shops
        # puts "Stats count: #{shops.length}, class: #{shops.class}"
        shops

    end

    def _get_shop_stats(link)
        # Some shops are listed, but not slicelife subscribers
        na = "not available"
        if link.css('._a9pofd').present?
            # puts "SUBSCRIBER"
            order_minimum   = link.css('._a9pofd').css('p._1nje18l')[0].text.split("-").first.gsub(/[^\d\.]/, '').to_f
            wait_time       = link.css('._a9pofd').css('p._1nje18l')[1].text
            min_wait_time   = wait_time.split("-").first.strip.to_i
            max_wait_time   = wait_time.split("-").last.strip.to_i
            delivery        = link.css('._a9pofd').css('p._1nje18l')[2].text.to_s.gsub(/[^\d\.]/, '').to_f
            subscribed      = true
            shop_stats      = {order_minimum: order_minimum, wait_time: wait_time, min_wait_time: min_wait_time, max_wait_time: max_wait_time, delivery: delivery, subscribed: subscribed}
            # puts "========================"
            # puts "SHOP STATS: #{shop_stats} "
        else
            # puts "not a subscriber"
            order_minimum   = na
            wait_time       = na
            min_wait_time   = na
            max_wait_time   = na
            delivery        = na
            subscribed      = false
            shop_stats      = {order_minimum: order_minimum, wait_time: wait_time, min_wait_time: min_wait_time, max_wait_time: max_wait_time, delivery: delivery, subscribed: subscribed}
            # puts "========================"
            # puts "SHOP STATS: #{shop_stats} "
        end
        shop_stats
    end
end