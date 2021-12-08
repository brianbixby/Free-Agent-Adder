require 'spec_helper'

YAHOO_USERNAME = 'email@gmail.com'
YAHOO_PASSWORD = 'password'
YAHOO_PLAYERS = 'https://basketball.fantasysports.yahoo.com/nba/12345/players' # Replace with Players page of your league

def login_yahoo(username, password)
  click_link('Sign in') if page.has_link?('Sign in')
  find('#login-username').set(username)
  find('#login-signin').click
  find('#login-passwd').set(password)
  find('#login-signin').click
  click_link('Cancel') if page.has_link?('Cancel') # Sometimes Yahoo will ask to secure your account, so we skip this.
  find('.escape-hatch').click if page.has_text?('Add a recovery method to make sure you always have access to your account') # Sometimes Yahoo will ask to add a phone number, so we skip this.
  find('.skip-now').click if page.has_text?('secure my account') # Sometimes Yahoo will ask to add a phone number, so we skip this.
end

def add_drop(free_agent, abbrev, droppable)
  find('#playersearchtext').set(free_agent)
  sleep 5 # Sometimes, the autocomplete dropdown interferes with clicking the Search button, so we wait a little
  page.find('input.Btn-primary[value="Search"]').click
  if page.has_selector?('tr.First.Last')
    if page.has_link?('Add Player')
      click_link('Add Player')
      if page.has_text?('Select a player to drop') 
        if page.find('input.button-no-drop')
          page.find('input.button-no-drop').click
          if page.has_text?('You have successfully added %s' % free_agent)
            puts 'Congratulations! %s was added.' % free_agent
            sleep 10
          else
            puts 'Could not claim %s' % free_agent
          end
        else
          page.find('td.player', :text => abbrev).find(:xpath, '..').find('button.add-drop-trigger-btn').click
          if page.has_css?('#submit-add-drop-button[value^="Create claim"]')
            puts 'Waivers have not cleared'
          else
            page.find('#submit-add-drop-button[value="Add %s, Drop %s"]' % [free_agent, droppable]).click
            puts 'Congratulations! %s was added.' % free_agent
            sleep 10
          end
        end
      else
        puts 'Sorry, there was a problem'
      end
    else
      puts 'Sorry, someone else probably got %s.' % free_agent
    end
  else
    puts 'Sorry, error'
  end
end

feature "Add free agents to Fantasy Basketball league" do

  background do
    visit YAHOO_PLAYERS
    login_yahoo(YAHOO_USERNAME, YAHOO_PASSWORD) # Replace with your username and password
  end

  after(:each) do
    Capybara.current_session.driver.quit
  end

  scenario "Log in and add/drop player" do
    add_drop("Royce O'Neale", "J. Richardson", "Josh Richardson") # Replace with players you want to add and drop
    # Do not insert additional calls to add_drop() -- Create new scenarios for more players
  end

  # scenario "Log in and add/drop player" do
  #   add_drop("Royce O'Neale", "J. Richardson", "Josh Richardson") # Replace with players you want to add and drop
  # end

end
