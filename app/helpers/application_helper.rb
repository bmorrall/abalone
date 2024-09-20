module ApplicationHelper
  include Pagy::Frontend

  # <span>&lt;&lt; Back</span>
  def back_span_tag
    content_tag(:span, "<< Back")
  end

  # <span>&lt;&lt; Cancel</span>
  def cancel_span_tag
    content_tag(:span, "<< Cancel")
  end
end
