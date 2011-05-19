pdf.text(wrap(sanitize(@document.content, :tags => %w(p i b s u))), :inline_format => true)
