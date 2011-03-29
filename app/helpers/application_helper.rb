module ApplicationHelper
  def flash_messages(flash)
    content_tag :div, :id => "flash" do
      [:notice, :alert, :errors].map do |type|
        content_tag :p, flash[type], :class => type.to_s if flash[type]
      end.join.html_safe
    end
  end
end
