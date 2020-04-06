class LeadsController < ApplicationController
    skip_before_action :verify_authenticity_token
    require 'sendgrid-ruby'
    include SendGrid
    
    def create
    lead = Lead.new
    puts "*************** ATTACHMENT NAME*************************"
    puts params[:Attachment]
    puts "****************************************"
    
          lead.lead_full_name = params[:Name]
          lead.lead_company_name = params[:Business_name]
          lead.lead_email = params[:Email]
          lead.lead_phone = params[:Phone]
          lead.project_name = params[:Project_name]
          lead.project_description = params[:Subject]
          lead.department_of_service = params[:Department]
          lead.lead_message = params[:Message]
          lead.created_at = Time.now
          
          attachment = params[:attachment]
          if attachment
            lead.file_name = params[:attachment].original_filename
            lead.attachment = params[:attachment].read
          end
          lead.save!
  
      # SENDGRID
          data = {
            personalizations: [
              {
                to: [
                  {
                    email: lead.lead_email
                  }
                ],
                dynamic_template_data: {
                    subject: "Confirmation Contact Request ",
                    FullName: lead.lead_full_name,
                    ProjectName: lead.project_name
                },
              }
            ],
            from: {
              email: "rocketelevator@gmail.com"
            },
            template_id: "d-c9c93ed00b254f0293e8832621031ffa"
          }
          puts "********************************************"
          sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
          puts sg
          puts "********************************************"
          response = sg.client.mail._("send").post(request_body: data)
          puts response.as_json
          puts "********************************************"
          create_lead_ticket(lead)
          redirect_to "/pages/index_one_page_elevator"
    end


    def create_lead_ticket(lead)
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
      ticket = ZendeskAPI::Ticket.new(@client, :id => 1)
      ZendeskAPI::Ticket.create!(@client, :subject => " #{lead.lead_full_name} from #{lead.lead_company_name}", 
      :comment => { :value => "
      The Contact #{lead.lead_full_name} from company #{lead.lead_company_name} can be reached at email: #{lead.lead_email}
      and at phone number: #{lead.lead_phone}.
      #{lead.department_of_service} has a project named #{lead.project_name} which
      would require contribution from Rocket Elevators. 

      Project Description:
      #{lead.project_description}

      Attached Message:
      #{lead.lead_message}

      The Contact uploaded an attachment.
      "
      },  
      :priority => "normal",
      :type => "question",
      requester: {"name": lead.lead_email})

    end
end
