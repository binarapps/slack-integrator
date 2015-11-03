module PullRequest
  class DrawReviewer

    def self.call
      User.order(Sequel.asc(:issues)).first.github_login
    end

  end
end
