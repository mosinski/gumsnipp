module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then "primary alert"
    when "success" then "success alert"
    when "error" then "danger alert"
    when "alert" then "warning alert"
    end
  end
end
