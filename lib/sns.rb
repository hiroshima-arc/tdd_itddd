# frozen_string_literal: true

require 'active_record'
require 'sqlite3'
require 'securerandom'
require './lib/db.rb'
require './lib/user_id.rb'
require './lib/user_name.rb'
require './lib/user.rb'
require './lib/user_service.rb'
require './lib/user_repository.rb'

DB.connect
DB.create
