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

class DB
  class << self
    def connect
      ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: ':memory:'
      )
    end

    def create
      InitialSchema.migrate(:up)
    end

    def destroy
      InitialSchema.migrate(:down)
    end
  end
end
