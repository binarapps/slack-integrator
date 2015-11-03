require 'octokit'

module PullRequest
  class AssignPullRequest
    attr_writer :client
    attr_accessor :assignee

    def initialize(pull_request_url)
      @pull_request_url = pull_request_url
    end

    def call
      @client = Octokit::Client.new(access_token: ENV.fetch('GITHUB_TOKEN'))
      assignee = PullRequest::DrawReviewer.call
      @assignee = assignee

      parsed = PullRequest::ParseRepository.new(@pull_request_url)
      parsed.call

      @client.update_issue(parsed.repo_name, parsed.issue_number, assignee: assignee)
    end

    def success_message
      "Pull request assigned to: #{@assignee}"
    end
  end
end
