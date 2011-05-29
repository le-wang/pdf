# encoding: utf-8

module ApplicationHelper
  def sanitized_content(content)
    sanitize(content, :tags => %w(p strong em s strike u ul ol li hr))
  end

  def wrap(content, pdf)
    paragraphs = content_to_paragraphs(content)
    while paragraph = paragraphs.shift
      render_paragraph(paragraph, pdf)
    end
  end
  
  private
  
  def render_paragraph(paragraph, pdf)
    pdf.instance_eval do
      if paragraph == "<hr />"
        move_down 5
        pdf.stroke { pdf.horizontal_rule }
        return
      end

      move_down 10

      markup = Nokogiri::HTML(paragraph.gsub(/\s+/, " "))

      mappings = { :em => :i, :strong => :b, :s => :strikethrough, :strike => :strikethrough }
      mappings.keys.each do |key|
        markup.xpath("//#{key}").each do |item|
          item.name = mappings[key].to_s
        end
      end
      
      markup.xpath('//ul/li').each do |item|
        item.replace "BULLET-POINT #{item.text}\n"
      end
      markup.xpath('//ol/li').each_with_index do |item, index|
        item.replace "#{index + 1}. #{item.inner_html}\n"
      end
      
      ['p', 'ol', 'ul'].each do |tag|
        markup.xpath("//#{tag}").each do |t|
          t.replace t.inner_html
        end
      end
      
      paragraph = markup.at_xpath('//body').inner_html.gsub("BULLET-POINT", "•").strip
      text paragraph, :inline_format => true
    end
  end

  def content_to_paragraphs(content)
    regex_string = "<p>.*?</p>|<ul>.*?</ul>|<ol>.*?</ol>|<hr />"
    regex = Regexp.new(regex_string, Regexp::MULTILINE)
    paragraphs = content.scan(regex)
  end
end
