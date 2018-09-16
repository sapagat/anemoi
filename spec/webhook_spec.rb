require 'rack/test'
require_relative '../system/dispatcher'

describe 'Webhook' do
  include Rack::Test::Methods

  def app
    Dispatcher.app
  end

  before do
    DirectionsGateway.configure do |config|
      config.api_key = api_key
    end
    allow(HttpClient).to receive(:get)
      .and_return(fixture)
  end

  it 'responds to an sms' do
    search_text = 'masquefa 45 benimaclet, bar aragon benimaclet'

    post "/webhook", {'Body' => search_text}

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include(testifier[:target])
    expect(last_response.body).to include(testifier[:first_step])
  end

  def fixture
    path = File.join(File.dirname(__FILE__), 'fixture.json')
    content = File.read(path)
    JSON.parse(content)
  end

  def testifier
    {
      target: 'Calle Barón de San Petrillo, 66, 46020 València, Valencia, Spain (0.4 km)',
      first_step: 'Head south on Carrer de Masquefa toward Carrer del Poeta Ricard Sanmartí (0.3 km)'
    }
  end

  def api_key
    'API_KEY'
  end
end
