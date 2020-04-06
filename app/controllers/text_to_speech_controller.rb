class TextToSpeechController < ApplicationController

require "json"
require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

      def watson
        # If using IAM
        authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
          apikey: ENV["TEXT_TO_SPEECH_API_KEY"]
        )

        # If you have username & password in your credentials use:
        # authenticator = IBMWatson::Authenticators::BasicAuthenticator.new(
        #   username: "{username}",
        #   password: "{password}"
        # )

        text_to_speech = IBMWatson::TextToSpeechV1.new(
        authenticator: authenticator
        )
        text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com"

        # Greetings to the logged users/employees
        first_name = current_employee.firstname
        # # There are currently XXX elevators deployed in the XXX buildings of your XXX customers
        nb_elevators = Elevator.all.count
        nb_buildings = Building.all.count
        nb_customers = Customer.all.count
        # # Currently, XXX elevators are not in Running Status and are being serviced
        nb_not_active_elevators = Elevator.where.not(:elevator_status => 'Active').count
        # # You currently have XXX quotes awaiting processing
        nb_quotes = Quote.all.count
        # # You currently have XXX leads in your contact requests
        nb_leads = Lead.all.count
        # # XXX Batteries are deployed across XXX cities
        nb_batteries = Battery.all.count
        building_entity = Address.where(:entity_type => "Building")
        nb_cities = building_entity.select(:city).count

        summary_file = "#{Rails.root}/public/summary.wav"
        File.open(summary_file, "wb") do |audio_file|
          response = text_to_speech.synthesize(
            text: "Hello,  #{first_name}!  Welcome to the Rocket Elevators's Admin Dashboard!
                  Currently, #{nb_not_active_elevators} elevators are not in Running Status and are being serviced.
                  There are currently #{nb_elevators} elevators deployed in the #{nb_buildings} buildings of your #{nb_customers} customers.
                  You currently have #{nb_quotes} quotes awaiting processing.
                  You currently have #{nb_leads} leads in your contact requests.
                  #{nb_batteries} Batteries are deployed across #{nb_cities} cities.
                  ",
            accept: "audio/wav",
            voice: "en-GB_KateVoice"
          )
          audio_file.write(response.result)
        end
      end
    end
