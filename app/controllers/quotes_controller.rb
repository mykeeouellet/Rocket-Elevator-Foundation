class QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
  quote = Quote.new

  quote.email = params[:userEmail]
  
      if params[:building_type] == 'commercial'

        quote.BuildingType = params[:building_type]
        quote.NbrFloors = params[:NbrFloorCommercial]
        quote.NbrBassements = params[:NbrBasementCommercial]
        quote.NbrElevators = params[:ResultElevator]
        quote.ElevatorQuality = params[:services]
        quote.ElevatorCost = params[:PriceUnit]
        quote.InstallationPrice = params[:InstallationCost]
        quote.TotalPrice = params[:TotalCost]
        quote.NbrBusinesses = params[:NbrSeparateBusinessCommercial||:NbrSeparateBusinessHybrid]
        quote.NbrParking = params[:NbrParkingCommercial||:NbrParkingCorporate||:NbrParkingHybrid]
      
      
      elsif params[:building_type] == 'residental'

        quote.BuildingType = params[:building_type]
        quote.NbrAppt = params[:NbrApartment]
        quote.NbrFloors = params[:NbrFloorResidential]
        quote.NbrBassements = params[:NbrBasementResidential]
        quote.NbrElevators = params[:ResultElevator]
        quote.ElevatorQuality = params[:services]
        quote.ElevatorCost = params[:PriceUnit]
        quote.InstallationPrice = params[:InstallationCost]
        quote.TotalPrice = params[:TotalCost]
  
      elsif params[:building_type] == 'corporate'

          quote.BuildingType = params[:building_type]
          quote.NbrFloors = params[:NbrFloorCorporate]
          quote.NbrBassements = params[:NbrBasementCorporate]
          quote.NbrElevators = params[:ResultElevator]
          quote.ElevatorQuality = params[:services]
          quote.ElevatorCost = params[:PriceUnit]
          quote.InstallationPrice = params[:InstallationCost]
          quote.TotalPrice = params[:TotalCost]
          quote.NbrBusinesses = params[:NbrSeparateBusinessHybrid]
          quote.NbrParking = params[:NbrParkingCorporate]
          quote.NbrRentalCompagnies = params[:NbrTenant]
          quote.NbrOccupanrtPerFloor = params[:NbrMaxOccupantCorporate]

        elsif params[:building_type] == 'hybrid'

          quote.BuildingType = params[:building_type]
          quote.NbrFloors = params[:NbrFloorHybrid]
          quote.NbrBassements = params[:NbrBasementHybrid]
          quote.NbrElevators = params[:ResultElevator]
          quote.ElevatorQuality = params[:services]
          quote.ElevatorCost = params[:PriceUnit]
          quote.InstallationPrice = params[:InstallationCost]
          quote.TotalPrice = params[:TotalCost]
          quote.NbrBusinesses = params[:NbrSeparateBusinessHybrid]
          quote.NbrParking = params[:NbrParkingHybrid]
          quote.NbrOccupanrtPerFloor = params[:NbrMaxOccupantHybrid]
          quote.WorkingHours = params[:NbrActivityHour]

    end
    quote.save!
    create_quote_ticket(quote)
    redirect_to "/pages/SubmissionForm"
  end

  def create_quote_ticket(quote)
    # require 'zendesk_api'
    @client = ZendeskAPI::Client.new do |config|
      config.url = "https://rocketelevators5360.zendesk.com/api/v2"
      config.username = ENV["ZENDESK_USERNAME"]
      config.token = ENV["ZENDESK_API_TOKEN"]
      config.retry = true
      config.raise_error_when_rate_limited = false
      require 'logger'
      config.logger = Logger.new(STDOUT)
    end

    ticket = ZendeskAPI::Ticket.new(@client, :id => 1,)
    ZendeskAPI::Ticket.create!(@client, :subject => "Quote: #{quote.id}", 
    :comment => { :value => "
    Quote Date: #{quote.created_at}
    Contact Email: #{quote.email}
    A new quote has been made for a #{quote.BuildingType} building with #{quote.NbrFloors} floors and a total of #{quote.NbrElevators} elevators.
    Cost for the elevators will be #{quote.ElevatorCost}$. For now, #{quote.ElevatorQuality} elevators are being deployed with an installation cost of #{quote.InstallationPrice}$.
    Total cost is estimated at #{quote.TotalPrice}$. Assigned employees can find quote #{quote.id} and further details directly in the admin panel of Rocket Elevators.
    
    Thank you.
    "
    },  
    :priority => "normal",
    :type => "task",
    requester: {"name": quote.email})

  end
end