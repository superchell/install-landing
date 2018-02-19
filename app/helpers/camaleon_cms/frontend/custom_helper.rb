module CamaleonCms::Frontend::CustomHelper

  def get_background_image(url)
    r = ''
    if url.present?
      r = "background-image: url(#{url});"
    end
    r
  end

  def get_background_color(color)
    r = ''
    if color.present?
      r = "background-color: #{color};"
    end
    r
  end

  def theme_img_url (path)
    asset_url theme_asset_path "images/#{path}"
  end

  def get_form_field (form, id)
    r = nil
    fields = JSON.parse(form.value).to_sym.values.first
    fields.each do |field|
      if field[:cid] == id
        r = field
        r[:name] = "fields[#{r[:cid]}]"
      end
    end
    r
  end

  def empty_field_group?(group)
    group.first.values.each do |v|
      return false if v.present?
    end
    true
  end

  #Lazy images
  def build_lazy_image(image, attr = {})
  html = ''
  image_min = image.cama_parse_image_version('x20', true)
  alt = attr[:alt] || ''
  html_class = attr[:class] || ''
  img_class = attr[:img_class] || ''

  if image != image_min
    html << "<a href=\"#{image}\"class=\"primary progressive replace #{html_class}\">
      <img src=\"#{image_min}\" class=\"preview #{img_class}\" alt=\"#{alt}\"/>
      </a>"
  else
    html << "<img src=\"#{image_min}\" class=\"#{img_class}\" alt=\"#{alt}\"/>"
  end

  raw html
  end

end