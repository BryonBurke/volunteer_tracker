require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

get('/') do
  redirect to('/home')
end

get('/home') do
  erb(:projects)
end


get ('/projects/new') do
  erb(:new_project)
end

post ('/projects') do
  name = params[:project_name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

get ('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end


delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end

get ('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  erb(:volunteer)
end

post ('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil, :artist_name => params[:artist_name], :year_recorded => params[:year_recorded], :studio => params[:studio]})
  volunteer.save()
  erb(:project)
end

patch ('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.update(params[:name], @project.id, params[:artist_name], params[:year_recorded])
  erb(:project)
end

delete ('/projects/:id/volunteers/:volunteer_id') do
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.delete
  @project = Project.find(params[:id].to_i())
  erb(:project)
end


get('/projects/search') do
  user_search = params[:search]
  @search = Project.search(user_search)
  erb(:search)
end
