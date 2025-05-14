require "test_helper"

class GymRegistrationFlowTest < ActionDispatch::IntegrationTest
  test "full gym registration workflow" do
    # 1. Create a new trainer
    get new_trainer_url
    assert_response :success
    
    assert_difference "Trainer.count" do
      post trainers_url, params: {
        trainer: {
          name: "New Trainer",
          specialization: "CrossFit",
          email: "new.trainer@example.com",
          phone: "555-777-8888"
        }
      }
    end
    
    new_trainer = Trainer.last
    assert_redirected_to trainer_url(new_trainer)
    follow_redirect!
    assert_select "h2", "Trainer Details"
    
    # 2. Create a new gym class with the created trainer
    get new_gym_class_url
    assert_response :success
    
    assert_difference "GymClass.count" do
      post gym_classes_url, params: {
        gym_class: {
          name: "CrossFit Basics",
          schedule: Time.current + 5.days,
          trainer_id: new_trainer.id
        }
      }
    end
    
    new_gym_class = GymClass.last
    assert_redirected_to gym_class_url(new_gym_class)
    follow_redirect!
    assert_select "h1", "Gym Class Details"
    
    # 3. Create a new member
    get new_member_url
    assert_response :success
    
    assert_difference "Member.count" do
      post members_url, params: {
        member: {
          name: "New Member",
          email: "new.member@example.com",
          phone: "555-111-9999",
          join_date: Date.today
        }
      }
    end
    
    new_member = Member.last
    assert_redirected_to member_url(new_member)
    follow_redirect!
    assert_select "h2", "Member Details"
    
    # 4. Verify relationships
    assert_equal new_trainer, new_gym_class.trainer
    
    # 5. Test adding a member to a class
    get gym_class_url(new_gym_class)
    assert_response :success
    
    # Add member to class using the add_member action
    post add_member_gym_class_url(new_gym_class), params: { member_id: new_member.id }
    assert_redirected_to gym_class_url(new_gym_class)
    
    # Verify member was added to class
    assert new_gym_class.reload.members.include?(new_member)
    
    # 6. Visit dashboard to see all entities
    get dashboard_url
    assert_response :success
  end
end 