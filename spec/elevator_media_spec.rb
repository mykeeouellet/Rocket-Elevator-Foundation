require 'ElevatorMedia'

RSpec.describe Streamer do
    describe ".getContent" do
        context "Testing the implementation of APOD" do
            it "Returns APOD as html" do
                expect(Streamer.getContent).to be_kind_of String
            end
        end 
    end 
end