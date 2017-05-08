module LocalSubdomain
  extend ActiveSupport::Concern

  included do
    before_action :redirect_to_lvh_me
  end

  def redirect_to_lvh_me
    return unless Rails.env.development?
    return if respond_to?(:skip_redirect?) && skip_redirect?

    redirect_domain = ENV['SERVER_REDIRECT_DOMAIN'] || 'lvh.me'

    served_by_lvh_me = !request.env['SERVER_NAME'][/#{redirect_domain}$/].nil?
    return if served_by_lvh_me

    http = request.env['rack.url_scheme']
    port = ENV['SERVER_REDIRECT_PORT'] || request.env['SERVER_PORT']
    path = request.env['ORIGINAL_FULLPATH']
    redirect_to "#{http}://#{redirect_domain}#{port == '80' ? '' : ':' + port}#{path}"
  end
end
