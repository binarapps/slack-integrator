RodaApp.route('pull_request') do |r|
  # POST /api/pull_requests
  r.post do
    action = PullRequest::AssignPullRequest.new(r.params['text'])
    action.call

    PostToSlack.say(:pull_request_bot, action.success_message)
    status(200)
  end
end
