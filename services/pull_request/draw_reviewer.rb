module PullRequest
  class DrawReviewer

    def self.call
      User.order(Sequel.asc(:issues)).first
    end

  end
end
