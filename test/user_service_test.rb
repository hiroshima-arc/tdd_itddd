# frozen_string_literal: true

require './test/test_helper'
require './lib/sns.rb'

class UserServiceTest < Minitest::Test
  describe 'ユーザーの重複を判定する' do
    def setup
      TestDB.connect
      TestDB.create
      @repository = UserRepository.new
      @service = UserService.new(user_repository: @repository)
    end

    def test_登録するユーザーがすでに存在している
      name = UserName.new('Bob')
      user = User.new(user_name: name)

      @repository.save(user)

      assert @service.exist?(user)
    end

    def test_登録するユーザーが存在していない
      name = UserName.new('Alice')
      user = User.new(user_name: name)

      refute @service.exist?(user)
    end

    def teardown
      TestDB.destroy
    end
  end
end
