# frozen_string_literal: true

class UserId
  attr_reader :value

  def initialize(value)
    raise if value.nil?

    @value = value
  end
end
