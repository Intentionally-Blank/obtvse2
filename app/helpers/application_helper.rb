require "kramdown"

module ApplicationHelper
  def is_admin?
    !!session[:user]
  end

  def markdown(text)
    Kramdown::Document.new(text,
      enable_coderay: true,
      coderay_default_lang: :ruby,
      coderay_wrap: :div,
      coderay_line_numbers: :table,
      coderay_line_numbers_start: 1,
      coderay_tab_width: 2,
      coderay_css: :style,
      coderay_bold_every: 10000
    ).to_html.html_safe
  end

  def component(component_name, locals = {}, &block)
    name = component_name.split("_").first
    render("components/#{name}/#{component_name}", locals, &block)
  end

  alias c component
end
