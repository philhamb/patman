module ApplicationHelper
  def logo 
    logo = image_tag("osteo-web.jpg", :alt => "Osteopath Centre", :class => "round") 
  end
  # Return a title on a per-page basis.
  def title
    base_title = "Patman"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

