# encoding: utf-8
# highlight: used in app/views/documents/show.pdf.prawn

module ApplicationHelper
  def wrap(content)
    markup = Nokogiri::HTML(content)
    markup.xpath('//s').each do |item|
      item.name = "strikethrough"
    end
    markup.xpath('//ul/li').each do |item|
      item.replace "* #{item.inner_html}"
    end
    markup.xpath('//ol/li').each_with_index do |item, index|
      item.replace "#{index + 1}. #{item.inner_html}"
    end
    markup.xpath('//ol').each do |list|
      list.replace list.inner_html
    end
    markup.xpath('//ul').each do |list|
      list.replace list.inner_html
    end
    markup.xpath('//p').each do |paragraph|
      paragraph.replace "\n" + paragraph.inner_html
    end

    markup.to_s.
      gsub(/.*<body>/m, "").
      gsub(/<\/body.*>/m, "").
      strip
  end
end
