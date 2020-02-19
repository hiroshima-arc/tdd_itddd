# frozen_string_literal: true

# UserID Value Object
class UserId
  attr_reader :value

  def initialize(value)
    raise if value.nil?

    @value = value
  end
end
