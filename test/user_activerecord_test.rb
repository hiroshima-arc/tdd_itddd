# frozen_string_literal: true

require './test/test_helper'
require './lib/sns.rb'

class ActiverecordTest < Minitest::Test
  describe '学習用テスト' do
    def setup
      @db = DB.new
      @db.create
    end

    def test_ユーザーを登録する
      User.create(user_name: UserName.new('Bob'))
      user = User.find_by(name: 'Bob')

      assert_equal 'Bob', user.name
    end

    def test_ユーザーを更新する
      User.create(user_name: UserName.new('Bob'))
      user = User.find_by(name: 'Bob')
      user.name = 'Alice'
      user.save
      user = User.find_by(name: 'Alice')

      assert_equal 'Alice', user.name
    end

    def test_ユーザーを削除する
      User.create(user_name: UserName.new('Bob'))
      user = User.find_by(name: 'Bob')
      user.destroy
      user = User.find_by(name: 'Bob')

      assert user.nil?
    end

    def teardown
      @db.destroy
    end
  end
end
