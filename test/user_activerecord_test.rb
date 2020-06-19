# frozen_string_literal: true

require './test/test_helper'
require 'active_record'

class InitialSchema < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :users
  end
end

class User < ActiveRecord::Base
end

class UserActiverecordTest < Minitest::Test
  describe 'ユーザーの重複を判定する' do
    def setup
      ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: 'sns_ar.db'
      )

      InitialSchema.migrate(:up)

      User.create(name: 'Bob')
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
      InitialSchema.migrate(:down)
    end
  end
end
