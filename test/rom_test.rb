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

  def listing
    select(:id, :name, :email).order(:name)
  end
end

class UserRepo < ROM::Repository[:users]
  commands :create, update: :by_pk, delete: :by_pk

  def query(conditions)
    users.where(conditions).map_to(::Entities::User)
  end

  def by_id(id)
    users.by_pk(id).map_to(::Entities::User).one!
  end

  def listing
    users.listing.map_to(::Entities::User)
  end

  def count
    users.count
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

      assert user.first.nil?
    end

    def test_ユーザー一覧を取得する
      @user_repo.delete(@user.id)
      @user_repo.create(name: 'Jane', email: 'jane@doe.org')
      @user_repo.create(name: 'Bob', email: 'bob@example.com')

      assert_equal @user_repo.count, 2
      assert_equal @user_repo.listing.last.name, 'Jane'
    end

    def teardown
      @user_repo.delete(@user.id)
      @user_repo.listing.each do |user|
        @user_repo.delete(user.id)
      end
    end
  end
end
