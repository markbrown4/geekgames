module DeviseHelper
  def devise_error_messages!
     html = ""
     return html if resource.errors.empty?

     resource.errors.each do |key, value|
       html << "<div class=\"flash alert-error\">Sorry, #{key} #{value}</div>"
     end
   
     return html.html_safe
  end
end