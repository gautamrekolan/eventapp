require 'test_helper'

class EventTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should not save event without name" do
    event = Event.new
    assert !event.save
  end

end
