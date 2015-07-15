require "sinatra"
require "sinatra/reloader"
require "sinatra/json"
require "pry"
require 'sinatra/cross_origin'

configure do
  enable :cross_origin
end

require "sqlite3"
require_relative "database_setup.rb"

require_relative "./models/assignment.rb"
require_relative "./models/collaborator.rb"
require_relative "./models/user.rb"

require_relative "./controllers/assignment_controller.rb"
require_relative "./controllers/collaborator_controller.rb"
require_relative "./controllers/api_controller.rb"