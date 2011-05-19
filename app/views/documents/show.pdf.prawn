# highlight: pdf.text
# pdf.text only recognizes <strikethrough> tag, not <s>, so wrap it.
# see http://prawn.majesticseacreature.com/docs/0.11.1/Prawn/Text.html

pdf.text(wrap(sanitize(@document.content, :tags => %w(p i b s u))), :inline_format => true)
