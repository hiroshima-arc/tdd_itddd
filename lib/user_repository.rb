# frozen_string_literal: true

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

class UserRepository
  def initialize
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:'
    )

    InitialSchema.migrate(:up)
  end

  def save(user)
    user.save
  end

  def find(user)
    User.find_by(name: user.name)
  end

  def destroy
    InitialSchema.migrate(:down)
  end
end
