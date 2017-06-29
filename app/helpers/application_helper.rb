module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'Hotel Advisor v2'
    return base_title if page_title.empty?
    return page_title
  end
end
