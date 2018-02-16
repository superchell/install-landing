module Themes::SiteOn::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def site_on_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def site_on_on_install_theme(theme)
    # # Sample Custom Field
    # unless theme.get_field_groups.where(slug: "fields").any?
    #   group = theme.add_field_group({name: "Main Settings", slug: "fields", description: ""})
    #   group.add_field({"name"=>"Background color", "slug"=>"bg_color"},{field_key: "colorpicker"})
    #   group.add_field({"name"=>"Links color", "slug"=>"links_color"},{field_key: "colorpicker"})
    #   group.add_field({"name"=>"Background image", "slug"=>"bg"},{field_key: "image"})
    # end

    # # Sample Meta Value
    # theme.set_meta("installed_at", Time.current.to_s) # save a custom value
  end

  # callback executed after theme uninstalled
  def site_on_on_uninstall_theme(theme)
  end

  def add_lazy_thumb(args)
    args[:versions] << "," unless args[:versions].blank?
    args[:versions] << " x20"
  end

  def aws_uploader_hook(args)
    args[:aws_settings][:aws_file_upload_settings] = lambda{|settings|
      settings[:cache_control] = 'max-age=15552000, public'
      settings[:expires] = "#{1.year.from_now.to_formatted_s(:rfc822)}"
      settings
    }
  end
end
