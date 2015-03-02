require 'github_api'

current_valuation = 0
current_karma = 0
the_time = Time.now

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: 7 })
  send_event('welcome', { title: "The amazing title", text: "The time is #{the_time}" })
end

github = Github.new user: 'jospablos', repo: 'Test_Dashboard'
commit_message= github.repos.commits.all('jospablos', 'Test_Dashboard').first.commit.message

SCHEDULER.every '60s', :first_in => 0 do
    send_event('recent_git_commit', {text:"#{commit_message}"})
end

