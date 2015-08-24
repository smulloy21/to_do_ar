ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('pry')
require("sinatra/activerecord")
require('./lib/list')
require('./lib/task')
