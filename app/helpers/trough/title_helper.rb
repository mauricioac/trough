module Trough::TitleHelper
  
  def title(text)
    @page_title ||= text
  end
  
  def page_title
    [Settings.site_name, @page_title].compact.join(' - ')
  end
  
end