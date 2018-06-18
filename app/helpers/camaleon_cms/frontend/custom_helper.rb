module CamaleonCms::Frontend::CustomHelper

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

  def build_lazy_image(image, attr = {})
    html = ''
    image_min = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
    alt = attr[:alt] || ''
    img_class = attr[:img_class] || ''
    width = attr[:width].present? ? "width=\"#{attr[:width]}\"" : ''
    height = attr[:height].present? ? "height=\"#{attr[:height]}\"" : ''

    versions = ''
    if attr[:versions]
      versions = "data-srcset=\"#{image.cama_parse_image_version('800x', true)} 769w, #{image.cama_parse_image_version('500x', true)} 320w\""
    end

    html << %(<img src="#{image_min}" #{width} #{height} data-src="#{image}" #{versions} class="lozad #{img_class}" alt="#{alt}"/>)
    raw html
  end

end