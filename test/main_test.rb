# frozen_string_literal: true

require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/autorun'

# 仕様
# SNS管理者として
# ユーザーを管理できるようにしたい
# なぜならソーシャルネットワークサービスだから
#
# TODOリスト
# - [x] IDと名前を持ったユーザーを作成する
# - [x] ユーザー名を更新する
# - [x] ユーザー名の文字数を確認する

class UserTest < Minitest::Test
  def setup
    id = UserId.new('1')
    name = UserName.new('Bob')
    @user = User.new(user_id: id, user_name: name)
  end

  def test_ユーザーが作成される
    assert_equal @user.id.value, '1'
    assert_equal @user.name.value, 'Bob'
  end

  def test_ユーザー名を更新する
    @user.change_name(user_name: UserName.new('Alice'))

    assert_equal @user.name.value, 'Alice'
  end

  def test_ユーザー名が３文字以上の場合はエラー
    e = assert_raises RuntimeError do
      UserName.new('a')
    end

    assert_equal 'ユーザー名は3文字以上です。', e.message
  end

  def test_ユーザー名を指定しない場合はエラー
    assert_raises ArgumentError do
      UserName.new
    end
  end

  def test_IDを指定しない場合はエラー
    assert_raises ArgumentError do
      UserId.new
    end
  end
end

class UserId
  attr_accessor :value

  def initialize(value)
    raise ArgumentError if value.nil?

    @value = value
  end
end

class UserName
  attr_reader :value

  def initialize(value)
    raise ArgumentError if value.nil?
    raise 'ユーザー名は3文字以上です。' if value.length < 3

    @value = value
  end
end

class User
  attr_reader :id, :name

  def initialize(user_id:, user_name:)
    @id = user_id
    @name = user_name
  end

  def change_name(user_name:)
    raise ArgumentError if name.nil?

    @name = user_name
  end
end
