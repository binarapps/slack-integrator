class PullRequestSlackConfig
  CONFIG = {
    'channel'          =>  ENV.fetch('PULL_REQUEST_CHANNEL'),
    'name'             => 'pull_request',
    'incoming_webhook' =>  ENV.fetch('PULL_REQUEST_INCOMING_WEBHOOK'),
    'outgoing_token'   =>  ENV.fetch('PULL_REQUEST_OUTGOING_TOKEN')
  }
end
