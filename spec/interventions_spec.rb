require "rails_helper"
require "interventions_controller"

RSpec.describe InterventionsController, type: :controller do
    describe "GET new intervention" do
        context"Testing paths from intervention to employees/sign_in" do
            it "Redirects you to employees/sign_in" do
                get :new
                expect(response).to redirect_to("/employees/sign_in")
            end 
        end 
    end

    describe "GET create" do
        context"Testing create method" do
            it "create @intervention" do
                @intervention = Intervention.create
                get :create
                @intervention.should be_an_instance_of Intervention
            end
        end 
    end
end