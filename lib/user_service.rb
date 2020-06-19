# frozen_string_literal: true

# UserService
class UserService
  def initialize(user_repository:)
    @repository = user_repository
  end

  def exist?(user)
    result = @repository.find(user)
    result.present?
  end
end
