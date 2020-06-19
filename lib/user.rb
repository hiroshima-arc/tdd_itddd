# frozen_string_literal: true

# User
class User
  attr_reader :id, :name

  def initialize(user_name:)
    @id = UserId.new(SecureRandom.uuid.to_str)
    @name = user_name
  end

  def user_name=(user_name)
    self.name = user_name.value
    @user_name = user_name
  end
end
