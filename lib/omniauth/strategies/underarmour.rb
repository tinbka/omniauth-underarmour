require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Underarmour < OmniAuth::Strategies::OAuth2

      option :name, "underarmour"

      option :client_options, {
          :site          => 'https://api.ua.com',
          :authorize_url => 'https://www.mapmyfitness.com/v7.1/oauth2/uacf/authorize/',
          :token_url     => 'https://www.mapmyfitness.com/v7.1/oauth2/access_token/'
      }

      option :response_type, 'code'
      option :authorize_options, %i(response_type redirect_uri)

      def build_access_token
        options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
        super
      end

      def basic_auth_header
        "Basic " + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      def query_string
        # Using state and code params in the callback_url causes a mismatch with
        # the value set in the fitbit application configuration, so we're skipping them
        ''
      end

      uid do
        access_token.params['user_id']
      end

      info do
        {
            :name         => "#{raw_info['user']['first_name']} #{raw_info['user']['last_name']}",
            :first_name   => raw_info['user']['first_name'],
            :last_name    => raw_info['user']['last_name'],
            :nickname     => raw_info['user']['username'],
            :gender       => raw_info['user']['gender'],
            :city         => raw_info['user']['locality'],
            :state        => raw_info['user']['region'],
            :country      => raw_info['user']['country'],
            :birthdate    => raw_info['user']['birthdate'].present? ? Date.parse(raw_info['user']['birthdate']) : nil,
            :date_joined  => Date.parse(raw_info['user']['date_joined']),
            :locale       => raw_info['user']['preferred_language'],
            :timezone     => raw_info['user']['time_zone']
        }
      end

      extra do
        {
            :raw_info => raw_info
        }
      end

      def raw_info
        @raw_info ||= MultiJson.load(access_token.request('get', 'https://api.ua.com/v7.1/user/self').body)
      end
    end
  end
end
