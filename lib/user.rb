# frozen_string_literal: true

# User
class User < ActiveRecord::Base
  def user_name
    @user_name = UserName.new(name)
  end

  def user_name=(user_name)
    self.name = user_name.value
    @user_name = user_name
  end

  def change_name(name)
    self.name = name
  end
end
