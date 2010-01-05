module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "matze.msh::WebDesign"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def menu_builder(page_id, tabs)
    content = ""
    tabs.each do |tab, ref|
      content << if page_id == ref
        content_tag('li', content_tag('a', tab, :href => nil ), :class => 'active') + " "
      else
        content_tag('li', content_tag('a', tab, :href => "/#{ref}" )) + " "
      end
    end
    content_tag(:ul, content)
  end

  def main_menu
    if current_user and current_user.has_role?('administrator')
      render :partial => 'layouts/admin_menu'
    else
      render :partial => 'layouts/main_menu'
    end
  end

  def user_logged_in?
    session[:user_id]
  end

end
