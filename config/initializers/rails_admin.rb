RailsAdmin.config do |config|

### Popular gems integration

  ## == Devise ==
  # WE USE DEVISE SO LET THE REST UNCOMMENTED ;)

  config.authenticate_with do
    warden.authenticate! scope: :employee
  end
  config.current_user_method(&:current_employee) # hook to the 'current_employee' method

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  # Static link in Rails Admin left navigation bar
  config.navigation_static_label = "API Links"

  config.navigation_static_links = {
    'IBM Watson' => '/watson',
    'Geolocation' => 'geolocation/index'
  }

  require Rails.root.join('lib', 'rails_admin', 'custom_actions.rb')
  # require Rails.root.join('lib', 'rails_admin', 'watson.rb')
  # RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Watson)
    config.actions do

      dashboard                     # mandatory
      index                         # mandatory
      new
      export
      bulk_delete
      show
      edit
      delete
      show_in_app
      # foo                           # custom_actions.rb
      # collection                    # custom_actions.rb
      root                            # custom_actions.rb
      # watson                        # watson.rb
      ## With an audit adapter, you can add:
      # history_index
      # history_show
    end
end
