require_relative 'directions_gateway'
require_relative 'criteria'
require 'twilio-ruby'
require 'logger'

class Controller < Sinatra::Base
  configure do
    disable :show_exceptions
  end

  post '/webhook' do
    search_text = params['Body']
    criteria = Criteria.new(search_text)

    instructions = DirectionsGateway.fetch(criteria.origin, criteria.destination)
    twiml = twiml_for(instructions)

    content_type 'text/xml'
    twiml.to_s
  end

  private

  def twiml_for(instructions)
    instructions_text = ''
    instructions_text += instructions[:target] + ";"
    instructions_text += instructions[:steps].join(';')
    Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: instructions_text
    end
  end
end
