out_file = File.new("dronemap.xml", "w")
out_file.puts("<dronemap>")
def render_doc(out_file,doc)
  if not doc.content.strip.empty?
    if doc.data['title'] == nil
      return
    end
    out_file.puts("<item><title>" + doc.data['title'] + "</title><content>#{doc.content.strip.encode(:xml => :text)}</content>")
    begin
      out_file.puts("<redirect>"+doc.data['redirect_to']+"</redirect>")
    rescue
    end
    begin
      out_file.puts("<permalink>"+doc.data['permalink']+"</permalink>")
    rescue
    end
    out_file.puts("</item>")
  end
end
Jekyll::Hooks.register :documents, :post_render do |doc|
  render_doc(out_file,doc)
end
Jekyll::Hooks.register :pages, :post_render do |doc|
  begin
    doc.length
    return
  rescue
  end
  render_doc(out_file,doc)
end
Jekyll::Hooks.register :site, :post_render do
  out_file.puts("</dronemap>")
  out_file.close
end
