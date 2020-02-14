require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/autorun'

class HelloTest < Minitest::Test
  def test_greeting
    assert_equal 'hello world', greeting
  end
end

def greeting
  'hello world'
end

# 仕様
# SNS管理者として
# ユーザーを管理できるようにしたい
# なぜならソーシャルネットワークサービスだから
#
# TODOリスト
# - [ ] IDと名前を持ったユーザーを作成する
# - [ ] ユーザー名を更新する
