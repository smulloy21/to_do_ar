require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('./lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

get("/") do
  @lists = List.all()
  erb(:index)
end

post('/lists/new') do
  name = params.fetch('name') # Here the value inputted by the user "name" was grabbed
    #and assigned to name
  list = List.new({:name => name}) #here a new instance of list (name) was created we use hash here .why?
  list.save() # here we save the new list the the database .this "save" method - part activerecord
  redirect('/')
end

get("/lists/:id") do
  @list = List.find(params.fetch('id').to_i())
  @tasks = @list.tasks()
  erb(:list)
end

post('/tasks/new') do
  description = params.fetch('description')
  @list = List.find(params.fetch('id').to_i()) # here we fetch the list so that we can find the list to save it as a variable so that we can use it again.
  @list.tasks.new({:description => description}) # created a new instance of task in that speccific list (Task.new({:description => description, :list_id => @list.id}))
  @list.save()
  redirect('/lists/' + @list.id.to_s())
end

get("/tasks/:id") do #
  @task = Task.find(params.fetch('id').to_i())
  @list = @task.list()
  erb(:task)
end

patch('/tasks/:id/edit') do
  description = params.fetch('description')
  @task = Task.find(params.fetch('id').to_i())
  @task.update({:description => description})
  redirect('/tasks/' + @task.id.to_s)
end

delete('/tasks/:id/delete') do
  @task = Task.find(params.fetch('id').to_i())
  @list=@task.list()
  @task.destroy()
  redirect('/lists/' + @list.id.to_s)
end
