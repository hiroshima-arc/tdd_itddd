# frozen_string_literal: true

require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]
require 'minitest/autorun'
require './lib/sns.rb'

class UserTest < Minitest::Test
  describe 'ユーザーを登録する' do
    def setup
      id = UserId.new('1')
      name = UserName.new('Bob')
      @user = User.new(user_id: id, user_name: name)
    end

    def test_IDと名前を持ったユーザーを作成する
      assert_equal '1', @user.id.value
      assert_equal 'Bob', @user.name.value
    end

    def test_ユーザー名が３文字未満で新規登録する場合はエラー
      e = assert_raises RuntimeError do
        UserName.new('a')
      end

      assert_equal 'ユーザー名は3文字以上です。', e.message
    end

    def test_ユーザー名が4文字で新規登録する場合は登録される
      user = User.new(user_id: UserId.new('1'), user_name: UserName.new('abcd'))
      assert_equal 'abcd', user.name.value
    end

    def test_ユーザー名を指定しない場合はエラー
      assert_raises RuntimeError do
        UserName.new(nil)
      end
    end

    def test_IDを指定しない場合はエラー
      assert_raises RuntimeError do
        UserId.new(nil)
      end
    end
  end

  describe 'ユーザーを更新する' do
    def setup
      id = UserId.new('1')
      name = UserName.new('Bob')
      @user = User.new(user_id: id, user_name: name)
    end

    def test_ユーザーの名前を更新する
      @user.change_name('Alic')
      assert_equal 'Alic', @user.name.value
    end

    def test_ユーザー名が３文字未満で更新する場合はエラー
      e = assert_raises RuntimeError do
        @user.change_name('a')
      end

      assert_equal 'ユーザー名は3文字以上です。', e.message
    end

    def test_ユーザー名が4文字で更新する場合は登録される
      user = User.new(user_id: UserId.new('1'), user_name: UserName.new('abc'))
      user.change_name('abcd')
      assert_equal 'abcd', user.name.value
    end
  end
end
