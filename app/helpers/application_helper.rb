module ApplicationHelper
  def wrap(content)
    content = content.gsub /<(\/?)s>/, "<\\1strikethrough>"
  end
end
