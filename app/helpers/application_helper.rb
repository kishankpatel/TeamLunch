module ApplicationHelper
  def format_date(date)
    date.strftime("%a, #{date.to_date.day.ordinalize} %b %Y")
  end
end
