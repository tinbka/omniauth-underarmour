require 'spec_helper'

describe "OmniAuth::Strategies::Underarmour" do
  subject do
    OmniAuth::Strategies::UnderArmour.new(nil, @options || {})
  end

  describe 'response_type' do
    it 'includes :code' do
      expect(subject.options["response_type"]).to include('code')
    end
  end

  describe 'authorize_options' do
    it 'includes :scope' do
      expect(subject.options["authorize_options"]).to include(:scope)
    end

    it 'includes :response_type' do
      expect(subject.options["authorize_options"]).to include(:response_type)
    end

    it 'includes :redirect_uri' do
      expect(subject.options["authorize_options"]).to include(:redirect_uri)
    end
  end

  context 'client options' do
    it 'has correct OAuth endpoint' do
      expect(subject.options.client_options.site).to eq('https://api.ua.com')
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://www.mapmyfitness.com/v7.1/oauth2/uacf/authorize/')
    end

    it 'has correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://www.mapmyfitness.com/v7.1/oauth2/access_token/')
    end
  end

  context 'auth header' do
    before :each do
      subject.options.client_id = 'testclientid'
      subject.options.client_secret = 'testclientsecret'
    end

    it 'returns the correct authorization header value' do
      expect(subject.basic_auth_header).to eq('Basic ' + Base64.strict_encode64("testclientid:testclientsecret"))
    end
  end

  context 'uid' do
    before :each do
      access_token = double('access_token')
      allow(access_token).to receive('params') { { 'user_id' => '123ABC' } }
      allow(subject).to receive(:access_token) { access_token }
    end

    it 'returns the correct id from raw_info' do
      expect(subject.uid).to eq('123ABC')
    end
  end

  context 'info' do
    before :each do
      allow(subject).to receive(:raw_info) {
        {
          "user" =>
          {
            "date_joined"        => "2010-01-01",
            "first_name"         => "John",
            "last_name"          => "Doe",
            "gender"             => "M",
            "last_initial"       => "D",
            "last_login"         => "2016-01-01",
            "locality"           => "Kansas City",
            "region"             => "MO",
            "country"            => "US",
            "time_zone"          => "America/Chicago"
            "username"           => "johnnie",
            "preferred_language" => "en-US",
            "birthdate"          => "2016-01-01"
          }
        }
      }
    end

    it 'returns the correct name from raw_info' do
      expect(subject.info[:name]).to eq("John Doe")
    end

    it 'returns the correct nickname from raw_info' do
      expect(subject.info[:nickname]).to eq("johnnie")
    end

    it 'returns the correct gender from raw_info' do
      expect(subject.info[:gender]).to eq("M")
    end

    it 'returns the correct city from raw_info' do
      expect(subject.info[:city]).to eq("Kansas City")
    end

    it 'returns the correct state from raw_info' do
      expect(subject.info[:state]).to eq("MO")
    end

    it 'returns the correct locale from raw_info' do
      expect(subject.info[:locale]).to eq("en-US")
    end

    it 'returns the correct birthdate from raw_info' do
      expect(subject.info[:birthdate]).to eq(Date.parse("2016-01-01"))
    end
  end

  context 'birthdate is empty' do
    before :each do
      allow(subject).to receive(:raw_info) {
        {
          "user" =>
          {
            "birthdate"   => "",
            "date_joined" => "2010-01-01"
          }
        }
      }
    end
    it 'returns nil' do
      expect(subject.info[:birthdate]).to be_nil
    end
  end
end
