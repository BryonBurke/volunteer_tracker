require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  redirect to('/home')
end

get('/home') do
  erb(:home)
end

get('/home/admin')do
  @projects = Project.all
  erb(:admin)
end

post('/home/admin/projects') do
  project = Project.new(params)
  project.save
  @projects = Project.all
  erb(:admin)
end

get('/home/admin/projects/new') do
  erb(:add_project)
end
