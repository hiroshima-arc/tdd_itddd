# frozen_string_literal: true

# User Value Object
class User
  attr_reader :id, :name

  def initialize(user_id:, user_name:)
    @id = user_id
    @name = user_name
  end

  def change_name(name)
    @name = UserName.new(name)
  end
end
