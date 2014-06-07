json.array!(@snipps) do |snipp|
  json.extract! snipp, :id, :title, :html_code, :css_code, :js_code, :user_id
  json.url snipp_url(snipp, format: :json)
end
