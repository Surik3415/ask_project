# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def full_title(page_title = '')
    base_title = 'MyApp'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: current_page }
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page
    css_class = title == current_page ? 'text-wite' : 'text-secondary'

    options[:class] = if options[:class]
                        "#{options[:class]} + #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end
end
