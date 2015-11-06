module PullRequest
  class ParseRepository
    attr_accessor :repo_name, :issue_number

    def initialize(repo)
      @repo = repo
    end

    def call
      @repo.slice!(ENV.fetch('REPOSITORY_URL'))
      # example ["example_company", "example_project", "pull", "99"]
      @repo = @repo.split('/')
      @repo_name = "#{@repo[0]}/#{@repo[1]}"
      @issue_number = @repo[3]
    end
  end
end
