module ApplicationHelper

  def flash_messages
    return content_tag(:div, flash[:notice], class: "alert alert-success") if flash[:notice]
    return content_tag(:div, flash[:alert], class: "alert alert-error") if flash[:alert]
  end

  def page_header(header)
    content_for :page_header, header
  end

  def breadcrumbize(*crumbs)
    @breadcrumbs = [*crumbs]
  end
  def breadcrumbs
    return '' if @breadcrumbs.nil?
    divider = content_tag(:span, "&raquo;".html_safe, class: "divider") 
    markup = ""
    markup << content_tag(:ul, class: "breadcrumb") do
      _markup = content_tag(:li, link_to("Home", root_path)+ (@breadcrumbs ? divider : ""))
      @breadcrumbs.each do |crumb|
        _markup << content_tag(:li, raw(crumb)+(crumb===@breadcrumbs.last ? "" : divider))
      end
      _markup.html_safe
    end
    markup.html_safe
  end

end
