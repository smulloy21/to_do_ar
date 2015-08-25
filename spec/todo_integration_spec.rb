require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('adding a new list', {:type => :feature}) do
  it('allows a user to add a list ') do
    visit('/')
    fill_in('name', :with => 'Homework')
    click_button('Add list')
    expect(page).to have_content('Homework')
  end
end

describe('updating a list', {:type => :feature}) do
  it('allows a user to update a list ') do
    list = List.new({:name => 'Epicodus Work'})
    list.save()
    visit('/')
    click_link('Epicodus Work')
    fill_in('name', :with => 'Homework')
    click_button('Update list')
    expect(page).to have_content('Homework')
  end
end

describe('deleting a list', {:type => :feature}) do
  it('allows a user to delete a list ') do
    list = List.new({:name => 'Schoolwork'})
    list.save()
    visit('/')
    click_link('Schoolwork')
    click_button('Delete list')
    expect(page).to have_no_content('School Work')
  end
end

describe('adding a task to a list', {:type => :feature}) do
  it('allows a user to add a task to a list ') do
    list = List.new({:name => 'Work'})
    list.save()
    visit('/')
    click_link('Work')
    fill_in('description', :with => 'Stuff')
    fill_in('due date', :with => '2015-08-25')
    click_button('Add task')
    expect(page).to have_content('Stuff')
  end
end

describe('updating a task', {:type => :feature}) do
  it('allows a user to update a list ') do
    list = List.new({:name => 'Coding HW'})
    list.save()
    task = Task.new({:description => 'watch video', :list_id => list.id(), :due_date => '2015-03-23'})
    task.save()
    visit('/')
    click_link('Coding HW')
    click_link('watch video')
    fill_in('description', :with => 'Watch video and read texts')
    click_button('Update task')
    expect(page).to have_content('Watch video and read texts')
  end
end

describe('deleting a task', {:type => :feature}) do
  it('allows a user to delete a task ') do
    list = List.new({:name => 'More stuff'})
    list.save()
    list.tasks.new({:description => 'do the stuff', :due_date => '2015-03-23'})
    list.save()
    visit('/')
    click_link('More stuff')
    click_link('do the stuff')
    click_button('Delete task')
    expect(page).to have_no_content('do the stuff')
  end
end
