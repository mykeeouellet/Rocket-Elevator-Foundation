require "concurrent"
require "erb"
require "json"
require "ibm_cloud_sdk_core"
require_relative "./common.rb"

# Module for the Watson APIs
module IBMWatson
  ##
  # The Text to Speech V1 service.
  class TextToSpeechV1 < IBMCloudSdkCore::BaseServicecd
      include Concurrent::Async

    # Synthesizes text to audio that is spoken in the specified voice. 
    def synthesize(text:, accept: nil, voice: nil, customization_id: nil)
        raise ArgumentError.new("text must be provided") if text.nil?

        headers = {
          "Accept" => accept
        }
        sdk_headers = Common.new.get_sdk_headers("text_to_speech", "V1", "synthesize")
        headers.merge!(sdk_headers)

        params = {
          "voice" => voice,
          "customization_id" => customization_id
        }

        data = {
          "text" => text
        }

        method_url = "/v1/synthesize"

        response = request(
          method: "POST",
          url: method_url,
          headers: headers,
          params: params,
          json: data,
          accept_json: false
        )
        response
      end
    end
  end
end

# Phrases

#       # Greetings to the logged users/employees
#       first_name = current_employee.firstname
#       # There are currently XXX elevators deployed in the XXX buildings of your XXX customers
#       nb_elevators = Elevator.all.count
#       nb_buildings = Building.all.count
#       nb_customers = Customer.all.count
#       # Currently, XXX elevators are not in Running Status and are being serviced
#       nb_not_active_elevators = Elevator.where.not(:elevator_status => 'Active').count
#       # You currently have XXX quotes awaiting processing
#       nb_quotes = Quote.all.count
#       # You currently have XXX leads in your contact requests
#       nb_leads = Lead.all.count
#       # XXX Batteries are deployed across XXX cities
#       nb_batteries = Battery.all.count
#       building_entity = Address.where(:entity_type => "Building")
#       nb_cities = building_entity.select(:city).count

#       "text" => "Hello, #{first_name} Welcome to the Rocket Elevators Admin Dashboard!
                  # Currently, #{nb_not_active_elevators} elevators are not in Running Status and are being serviced.
                  # There are currently #{nb_elevators} elevators deployed in the #{nb_buildings} buildings of your #{nb_customers} customers.
                  # You currently have #{nb_quotes} quotes awaiting processing.
                  # You currently have #{nb_leads} leads in your contact requests.
                  # #{nb_batteries} Batteries are deployed across #{nb_cities} cities.",


