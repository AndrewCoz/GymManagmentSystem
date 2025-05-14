require "test_helper"

class TrainerTest < ActiveSupport::TestCase
  setup do
    @trainer = trainers(:one)
  end
  
  test "should be valid" do
    assert @trainer.valid?
  end
  
  test "name should be present" do
    @trainer.name = nil
    assert_not @trainer.valid?
    assert_includes @trainer.errors[:name], "can't be blank"
  end
  
  test "specialization should be present" do
    @trainer.specialization = nil
    assert_not @trainer.valid?
    assert_includes @trainer.errors[:specialization], "can't be blank"
  end
  
  test "email should be present" do
    @trainer.email = nil
    assert_not @trainer.valid?
    assert_includes @trainer.errors[:email], "can't be blank"
  end
  
  test "email should be unique" do
    duplicate_trainer = @trainer.dup
    duplicate_trainer.email = @trainer.email
    @trainer.save
    assert_not duplicate_trainer.valid?
    assert_includes duplicate_trainer.errors[:email], "has already been taken"
  end
  
  test "email should be valid format" do
    @trainer.email = "invalid_email"
    assert_not @trainer.valid?
    assert_includes @trainer.errors[:email], "is invalid"
  end
  
  test "phone should be present" do
    @trainer.phone = nil
    assert_not @trainer.valid?
    assert_includes @trainer.errors[:phone], "can't be blank"
  end
  
  test "should have many gym classes" do
    assert_respond_to @trainer, :gym_classes
  end
  
  test "should have many members through gym classes" do
    assert_respond_to @trainer, :members
  end
  
  test "destroying trainer should destroy associated gym classes" do
    trainer_with_classes = trainers(:one)
    assert_difference "GymClass.count", -1 do
      trainer_with_classes.destroy
    end
  end
end
