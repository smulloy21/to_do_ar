require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('adding a new list', {:type => :feature}) do
  it('allows a user to add a list ') do
    visit('/')
    fill_in('name', :with => 'Jane Brown')
    click_button('Add list')
    expect(page).to have_content('Jane Brown')
  end
end
