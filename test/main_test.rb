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
    username = UserName.new('Bob')
    @user = User.new('1', username)
  end

  def test_ユーザーが作成される
    assert_equal @user.id, '1'
    assert_equal @user.name.value, 'Bob'
  end

  def test_ユーザー名を更新する
    @user.name = 'Alice'

    assert_equal @user.name, 'Alice'
  end

  def test_ユーザー名が３文字以上の場合はエラー
    e = assert_raises RuntimeError do
      UserName.new('a')
    end

    assert_equal 'ユーザー名は3文字以上です。', e.message
  end
end

class UserName
  attr_accessor :value

  def initialize(value)
    raise ArgumentError if value.nil?
    raise 'ユーザー名は3文字以上です。' if value.length < 3

    @value = value
  end
end

class User
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
