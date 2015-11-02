describe 'PullRequest::DrawReviewer' do

  context 'when there is a reviewer with smallest reviews count' do
    let!(:user) { FactoryGirl.create(:user, issues: 10) }
    let!(:another_user) { FactoryGirl.create(:user, issues: 11) }
    let!(:yet_another_user) { FactoryGirl.create(:user, issues: 3) }

    it 'should draw that person' do
      expect(PullRequest::DrawReviewer.call).to eq(yet_another_user)
    end

  end

  context 'when all users have the same amount of issues' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:another_user) { FactoryGirl.create(:user) }
    let!(:yet_another_user) { FactoryGirl.create(:user) }

    it 'should draw first person from the top' do
      expect(PullRequest::DrawReviewer.call).to eq(user)
    end
  end

end
