require 'bundler'
Bundler.require

configure :development do
  set :database, "sqlite3:db/database.db"
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV["DATABAASE_URL"])
end