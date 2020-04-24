require 'rails_helper'
require 'quotes_controller'

RSpec.describe QuotesController, type: :controller do
    describe "GET create Quote" do
        context "Testing paths when a Quote is created" do
            it "Redirects you to /pages/SubmissionForm" do
                get :create
                expect(response).to redirect_to("/pages/SubmissionForm")
            end
        end
    end

    describe "GET create" do
        context"Testing create method" do
            it "create @quote" do
                @quote = Quote.create
                get :create
                @quote.should be_an_instance_of Quote
            end
        end 
    end
end