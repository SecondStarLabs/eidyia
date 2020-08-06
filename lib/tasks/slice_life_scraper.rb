require 'watir'
require 'webdrivers'
require 'nokogiri'
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
#  puts "links_fragment parents are  #{links_fragment.ancestors}"

  @doc.css('._1j8jxoz').each do |link|
      puts "found link"
      link_href = link.attributes["href"]
      img_src = link.css('._19wyhi7').css('img').attr('src')
      location_name = link.css('._1pkohes').css('p._1e3rlyy').text
      location_rating_and_no_reviews = link.css('._1pkohes').css('._1ezh8s1').text
      address = link.css('._1pkohes').css('._4qdonk').text
      order_minimum = link.css('._a9pofd').css('p._1nje18l')[0].text
      wait_time = link.css('._a9pofd').css('p._1nje18l')[1].text
      delivery = link.css('._a9pofd').css('p._1nje18l')[2].text
      
      puts order_minimum
      puts wait_time
      puts delivery
  end
# puts all_html

browser.close
