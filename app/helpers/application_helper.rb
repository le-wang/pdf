# encoding: utf-8
# highlight: used in app/views/documents/show.pdf.prawn

module ApplicationHelper
  def wrap(content)
    content.
      gsub(/<(\/?)s>/, "<\\1strikethrough>").
      gsub(/<p>/, "\n").
      gsub(/<\/p>/, "").
      gsub(/<\/?[ou]l>/, "").
      gsub /<li>(.*)<\/li>/ do
        "• #{$1}"
      end
  end
end
