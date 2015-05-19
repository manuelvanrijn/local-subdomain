module LocalSubdomain
  extend ActiveSupport::Concern

  included do
    before_filter :redirect_to_lvh_me
  end

  def redirect_to_lvh_me
    return unless Rails.env.development?
    served_by_lvh_me = !request.env['SERVER_NAME'][/lvh.me$/].nil?
    return if served_by_lvh_me

    http = request.env['rack.url_scheme']
    port = request.env['SERVER_PORT']
    path = request.env['ORIGINAL_FULLPATH']
    redirect_to "#{http}://lvh.me:#{port}#{path}"
  end
end
