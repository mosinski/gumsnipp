module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then "primary alert"
    when "success" then "success alert"
    when "error" then "danger alert"
    when "alert" then "warning alert"
    end
  end

  def iframe_url(snipp,version)
    case Rails.env
    when "production"
      "http://iframe.gumsnipp.com/snipp/#{snipp}-v#{version}"
    when "development"
      "https://lh5.googleusercontent.com/-6M5SeBloZWg/UlL5OfD_apI/AAAAAAAAYME/w6VWLIjdp2A/w500-h400-no/no-cover-image.jpg"
    end
  end

  def to_checked
    Snipp.where(published: false, to_check: true).search(params[:search], params[:page]).count
  end

  def lighten_color(hex_color, amount=0.6)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
    rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
    rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
    "#%02x%02x%02x" % rgb
  end
end
