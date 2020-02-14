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
    @user = User.new('1', 'Bob')
  end

  def test_ユーザーが作成される
    assert_equal @user.id, '1'
    assert_equal @user.name, 'Bob'
  end

  def test_ユーザー名を更新する
    @user.name = 'Alice'

    assert_equal @user.name, 'Alice'
  end

  def test_ユーザー名が３文字以上の場合はエラー
    e = assert_raises RuntimeError do
      User.new(1, 'a')
    end

    assert_equal 'ユーザー名は3文字以上です。', e.message
  end
end

class User
  attr_accessor :id, :name

  def initialize(id, name)
    raise 'ユーザー名は3文字以上です。' if name.length < 3

    @id = id
    @name = name
  end
end
