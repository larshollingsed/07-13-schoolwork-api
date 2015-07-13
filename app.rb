require "sinatra"
require "sinatra/reloader"
require "sinatra/json"
require "pry"

require "sqlite3"
require_relative "database_setup.rb"

require_relative "./models/assignment.rb"
require_relative "./models/collaborator.rb"

require_relative "./controllers/assignment_controller.rb"
require_relative "./controllers/collaborator_controller.rb"