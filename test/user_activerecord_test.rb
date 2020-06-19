# frozen_string_literal: true

require './test/test_helper'
require './lib/sns.rb'

class UserActiverecordTest < Minitest::Test
  describe 'ユーザーの重複を判定する' do
    def setup
      @repository = UserRepository.new
      @service = UserService.new(user_repository: @repository)
      User.create(user_name: UserName.new('Bob'))
    end

    def test_登録するユーザーがすでに存在している
      user = User.find_by(name: 'Bob')

      assert_equal 'Bob', user.name
    end

    def test_登録するユーザーが存在していない
      user = User.find_by(name: 'Alice')

      assert user.nil?
    end

    def teardown
      @repository.destroy
    end
  end
end
