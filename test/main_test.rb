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
# - [ ] IDと名前を持ったユーザーを作成する
# - [ ] ユーザー名を更新する

class UserTest < Minitest::Test
  def test_ユーザーが作成される
    user = User.new('1', 'Bob')

    assert_equal user.id, '1'
    assert_equal user.name, 'Bob'
  end
end

class User
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
