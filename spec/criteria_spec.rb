require_relative '../system/criteria'

describe 'Criteria' do
  it 'reads the origin from the search text' do
    text = 'masquefa 45 benimaclet, bar aragon benimaclet'

    criteria = Criteria.new(text)

    expect(criteria.origin).to eq('masquefa 45 benimaclet')
  end

  it 'reads the destination from the search text' do
    text = 'masquefa 45 benimaclet, bar aragon benimaclet'

    criteria = Criteria.new(text)

    expect(criteria.destination).to eq('bar aragon benimaclet')
  end
end
