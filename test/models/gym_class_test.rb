require "test_helper"

class GymClassTest < ActiveSupport::TestCase
  setup do
    @gym_class = gym_classes(:one)
  end
  
  test "should be valid" do
    assert @gym_class.valid?
  end
  
  test "name should be present" do
    @gym_class.name = nil
    assert_not @gym_class.valid?
    assert_includes @gym_class.errors[:name], "can't be blank"
  end
  
  test "schedule should be present" do
    @gym_class.schedule = nil
    assert_not @gym_class.valid?
    assert_includes @gym_class.errors[:schedule], "can't be blank"
  end
  
  test "schedule should not be in the past" do
    @gym_class.schedule = Time.now - 1.day
    assert_not @gym_class.valid?
    assert_includes @gym_class.errors[:schedule], "must be in the future"
  end
  
  test "should belong to a trainer" do
    assert_instance_of Trainer, @gym_class.trainer
  end
  
  test "should have and belong to many members" do
    assert_respond_to @gym_class, :members
  end
  
  test "should be able to add members" do
    assert_difference "@gym_class.members.count" do
      @gym_class.members << members(:one)
    end
  end
end
