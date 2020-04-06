require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminPublish
end
 
module RailsAdmin
  module Config
    module Actions
      class NewTab < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here. 
        # Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
 
        register_instance_option :bulkable? do
          true
        end
 
        register_instance_option :controller do
          Proc.new do
            
            redirect_to back_or_index
          end
        end
      end
    end
  end
end