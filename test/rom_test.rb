# frozen_string_literal: true

require './test/test_helper'
require 'rom'
require 'rom-sql'
require 'rom-repository'

module Entities
  class User
    attr_reader :id, :name, :email

    def initialize(attributes)
      @id, @name, @email = attributes.values_at(:id, :name, :email)
    end
  end
end

class Users < ROM::Relation[:sql]
  struct_namespace Entities

  schema(infer: true)
end

class UserRepo < ROM::Repository[:users]
  commands :create, update: :by_pk, delete: :by_pk

  def query(conditions)
    users.where(conditions).to_a
  end

  def by_id(id)
    users.by_pk(id).one!
  end
end

class RomTest < Minitest::Test
  describe '学習用テスト' do
    def setup
      rom = ROM.container(:sql, 'sqlite::memory') do |conf|
        conf.default.create_table(:users) do
          primary_key :id
          column :name, String, null: false
          column :email, String, null: false
        end

        conf.register_relation(Users)
      end

      @user_repo = UserRepo.new(rom)
      @user = @user_repo.create(name: 'Jane', email: 'jane@doe.org')
    end

    def test_ユーザーを登録する
      assert_equal 'Jane', @user.name
      assert_equal 'jane@doe.org', @user.email
    end

    def test_ユーザーを検索する
      user = @user_repo.query(name: 'Jane')

      assert_equal 'Jane', user.first.name
    end

    def test_ユーザーをID検索する
      user = @user_repo.by_id(@user.id)

      assert_equal 'Jane', user.name
    end

    def test_ユーザーを更新する
      user = @user_repo.create(name: 'Jane', email: 'jane@doe.org')
      updated_user = @user_repo.update(user.id, name: 'Jane Doe')

      assert_equal 'Jane Doe', updated_user.name
      assert_equal 'jane@doe.org', updated_user.email
    end

    def test_ユーザーを削除する
      user = @user_repo.create(name: 'Bob', email: 'bob@doe.org')
      @user_repo.delete(user.id)
      user = @user_repo.query(name: 'Bob')

      assert user.empty?
    end

    def teardown
      @user_repo.delete(@user.id)
    end
  end
end
