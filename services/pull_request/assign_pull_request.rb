module PullRequest
  class AssignPullRequest
    attr_accessor :client

    def initialize(params, issue, assigne, repo)
      @issue = issue
      @assigne = assigne
      @repo = repo
    end

    def call
      @client = Octokit::Client.new(:access_token => ENV.fetch('GITHUB_TOKEN'))
      assigne = PullRequest::DrawReviewer.call

      parsed = PullRequest::ParseRepository.new(@repo)
      parsed.call

      @client.update_issue(parsed.repo_name, parsed.issue, assigne: assigne)
    end

  end
end
