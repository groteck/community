module BlogEntriesHelper
  def resumen
    more = blog_entry.content.index("<!-more->")
    truncate(blog_entry.content, :length => more ) 
  end
end
