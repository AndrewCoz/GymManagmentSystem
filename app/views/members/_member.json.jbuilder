json.extract! member, :id, :name, :email, :phone, :membership_type, :join_date, :created_at, :updated_at
json.url member_url(member, format: :json)
