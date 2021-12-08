<!--
  Title: Free Agent Adder for Yahoo Fantasy Basketball Leagues
  Description: Automatically add free agents in Yahoo fantasy basketball leagues. Written in Ruby leveraging Selenium Webdriver.
  Author: Brian Bixby
  -->

# free-agent-Adder
Automate adding of free agents in fantasy basketball leagues.

This was developed to automate the adding and dropping of players on a Yahoo fantasy basketball team. This allows users to automate this process so that when waivers clear, fantasy owners can continue to sleep in their beds.

### How to use ###

1. Install Ruby
2. Clone this repo
3. Install and run bundler gem:
* `gem install bundler`
* `bundle install`
4. Modify your script to log into fantasy sites along with adding/dropping players.
5. Run RSpec: `rspec spec/yahoo/add_free_agent.rb`

### Scheduling ###

This spec does not schedule execution on its own. It is recommended that you run RSpec via cron job or scheduled Windows Task. A Mac Cronjob would look something like:

* Schedule cronjob in terminal: `crontab -e`
* Example cronjob: `0 0 8 12 * cd /Users/brian/Desktop/Free-Agent-Adder && rspec spec/yahoo/add_free_agent.rb > free-agent-adder.log`
