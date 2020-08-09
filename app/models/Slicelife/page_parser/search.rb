require 'nokogiri'
class Slicelife::PageParser::Search
    def initialize(fragment: fragment)
        @fragment = fragment
    end

    def parse
        shops = []
        @fragment.css('._1j8jxoz').each do |link|
            puts "found link"
            link_href                       = link.attributes["href"].value.to_s
            img_src                         = link.css('._19wyhi7').css('img').attr('src').value.to_s
            location_name                   = link.css('._1pkohes').css('p._1e3rlyy').text.to_s.strip
            location_rating_and_no_reviews  = link.css('._1pkohes').css('._1ezh8s1').text
            location_rating                 = location_rating_and_no_reviews.split("(").first.to_f
            no_reviews                      = location_rating_and_no_reviews.split("(").last.to_i
            address                         = link.css('._1pkohes').css('._4qdonk').text.to_s
            parsed_address                  = _parse_address(address)
            shop_stats                      = _get_shop_stats(link)
            # puts shop_stats
            
            shop_hash = {link_href: link_href, img_src: img_src, location_name: location_name, location_rating: location_rating, no_reviews: no_reviews, address: address}
            # puts shop_hash
            shop_hash = shop_hash.merge(shop_stats)
            shop = shop_hash.merge(parsed_address)
            # shop = shop.merge(parsed_address)
            shops << shop
        end
        # puts shops
        # puts "Stats count: #{shops.length}, class: #{shops.class}"
        shops

    end

    def _get_shop_stats(link)
        # Some shops are listed, but not slicelife subscribers
        amount_not_available = 999
        if link.css('._a9pofd').present?
            # puts "SUBSCRIBER"
            @order_minimum  = OpenStruct.new({id: "palooza"})
            order_minimum   = _parse_order_minimum(link.css('._a9pofd').css('p._1nje18l')[0].text)
            wait_time       = link.css('._a9pofd').css('p._1nje18l')[1].text
            min_wait_time   = wait_time.split("-").first.strip.to_i
            max_wait_time   = wait_time.split("-").last.strip.to_i
            delivery        = link.css('._a9pofd').css('p._1nje18l')[2].text.to_s.gsub(/[^\d\.]/, '').to_f
            subscribed      = true
            shop_stats      = {order_minimum_low: order_minimum.low, order_minimum_high: order_minimum.high, wait_time: wait_time, min_wait_time: min_wait_time, max_wait_time: max_wait_time, delivery: delivery, subscribed: subscribed}
            # puts "========================"
            # puts "SHOP STATS: #{shop_stats} "
        else
            # puts "not a subscriber"
            omh                 = amount_not_available
            oml                 = amount_not_available
            wait_time           = amount_not_available
            min_wait_time       = amount_not_available
            max_wait_time       = amount_not_available
            delivery            = amount_not_available
            subscribed          = false
            shop_stats          = {order_minimum_low: oml, order_minimum_high: omh, wait_time: wait_time, min_wait_time: min_wait_time, max_wait_time: max_wait_time, delivery: delivery, subscribed: subscribed}
            # puts "========================"
            # puts "SHOP STATS: #{shop_stats} "
        end
        shop_stats
    end

    def _parse_address(address)
        city        = address.split(", ")[1]
        state_abbr  = address.split(", ")[2]
        {city: city, state_abbr: state_abbr}
    end

    def _parse_order_minimum(order_minimum_text) #some text is a range, not a number
        if order_minimum_text.match(/-/)
            puts "order_minimum is a range! #{order_minimum_text}"
            low     = order_minimum_text.split("-").first.gsub(/[^\d\.]/, '').to_f
            high    = order_minimum_text.split("-").last.gsub(/[^\d\.]/, '').to_f
            @order_minimum.low = low
            @order_minimum.high = high
        else 
            value   = order_minimum_text.gsub(/[^\d\.]/, '').to_f
            @order_minimum.low = value
            @order_minimum.high = value
        end
        puts @order_minimum
        @order_minimum
    end
end