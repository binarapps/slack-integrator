describe 'PullRequest::ParseRepository' do

  context 'within given repo url' do
    let(:repo_url) { 'https://github.com/example_company/example_project/pull/99' }

    it 'should parse repo name and issue number' do
      action = PullRequest::ParseRepository.new(repo_url)
      action.call
      expect(action.repo_name).to eq('example_company/example_project')
      expect(action.issue_number).to eq('99')
    end

  end

end
