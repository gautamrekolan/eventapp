require 'spec_helper'

describe Event do 
  let(:event) { Event.new :name => "my sample event",
                          :starttime => Time.now,
                          :endtime => Time.now + 2.hours,
                          :user_id => 1,
                          :description => "description should be over a certain amount of characters but i forget how many",
                          :place_id => 1,
                          :category_id => 1 }
                          
  it "can be instantiated" do
    event.should be_an_instance_of(Event)
  end
  it "can be saved successfully" do 
    event.save be_persisted
  end
end