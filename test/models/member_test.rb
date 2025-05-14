require "test_helper"

class MemberTest < ActiveSupport::TestCase
  setup do
    @member = members(:one)
  end
  
  test "should be valid" do
    assert @member.valid?
  end
  
  test "name should be present" do
    @member.name = nil
    assert_not @member.valid?
    assert_includes @member.errors[:name], "can't be blank"
  end
  
  test "email should be present" do
    @member.email = nil
    assert_not @member.valid?
    assert_includes @member.errors[:email], "can't be blank"
  end
  
  test "email should be unique" do
    duplicate_member = @member.dup
    duplicate_member.email = @member.email
    @member.save
    assert_not duplicate_member.valid?
    assert_includes duplicate_member.errors[:email], "has already been taken"
  end
  
  test "email should be valid format" do
    @member.email = "invalid_email"
    assert_not @member.valid?
    assert_includes @member.errors[:email], "is invalid"
  end
  
  test "phone should be present" do
    @member.phone = nil
    assert_not @member.valid?
    assert_includes @member.errors[:phone], "can't be blank"
  end
  
  test "membership_type should default to Basic" do
    new_member = Member.new(
      name: "Test Member",
      email: "test@example.com",
      phone: "555-555-5555",
      join_date: Date.today
    )
    assert new_member.valid?
    assert_equal "Basic", new_member.membership_type
  end
  
  test "membership_type should be valid" do
    @member.membership_type = "Invalid Type"
    assert_not @member.valid?
    assert_includes @member.errors[:membership_type], "is not included in the list"
  end
  
  test "join_date should be present" do
    @member.join_date = nil
    assert_not @member.valid?
    assert_includes @member.errors[:join_date], "can't be blank"
  end
  
  test "should be able to associate with gym classes" do
    assert_difference "@member.gym_classes.count" do
      @member.gym_classes << gym_classes(:one)
    end
  end
end
