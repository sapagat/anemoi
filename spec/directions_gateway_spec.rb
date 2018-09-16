require_relative '../system/directions_gateway'

describe 'Directions Gateway' do
  before do
    DirectionsGateway.configure do |config|
      config.api_key = api_key
    end
    allow(HttpClient).to receive(:get)
      .and_return(fixture)
  end

  it 'fetches the information from an api' do
    origin = 'Masquefa 45 Benimaclet'
    destination = 'Bar Aragon Benimaclet'

    instructions = DirectionsGateway.fetch(origin, destination)

    expect(HttpClient).to have_received(:get).with(api_url, {
      origin: 'Masquefa+45+Benimaclet',
      destination: 'Bar+Aragon+Benimaclet',
      mode: 'walking',
      key: api_key
    })
  end

  it 'provides information of the interpreted destination' do
    origin = 'Masquefa 45 Benimaclet'
    destination = 'Bar Aragon Benimaclet'

    instructions = DirectionsGateway.fetch(origin, destination)

    expect(instructions[:target]).to eq(testifier[:target])
  end

  it 'explains each step' do
    origin = 'Masquefa 45 Benimaclet'
    destination = 'Bar Aragon Benimaclet'

    instructions = DirectionsGateway.fetch(origin, destination)

    expect(instructions[:steps].first).to eq(testifier[:first_step])
  end

  def api_url
    'https://maps.googleapis.com/maps/api/directions/json'
  end

  def api_key
    'API_KEY'
  end

  def testifier
    {
      target: 'Calle Barón de San Petrillo, 66, 46020 València, Valencia, Spain (0.4 km)',
      first_step: 'Head south on Carrer de Masquefa toward Carrer del Poeta Ricard Sanmartí (0.3 km)'
    }
  end

  def fixture
    path = File.join(File.dirname(__FILE__), 'fixture.json')
    content = File.read(path)
    JSON.parse(content)
  end
end
