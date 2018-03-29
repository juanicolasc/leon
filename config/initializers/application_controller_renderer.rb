# Be sure to restart your server when you modify this file.
require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'
# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
  class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page), :class => "page-link"), :class => "page-item")
      else
        tag(:li, link(page, page, :rel => rel_value(page), :class => "page-link"), :class => "page-item active")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page, :class => "page-link"), :class => "page-item")
      else
        tag(:li, link(text, page, :class => "page-link"), :class => "page-item disabled")
      end
    end

    def html_container(html)
      tag(:ul, html, container_attributes)
    end

  end