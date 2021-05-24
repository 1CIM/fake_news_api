RSpec.describe 'GET /api/backyards/:id', type: :request do
  let!(:backyard_article) { create(:backyard_article) }

  describe 'successfully' do
    before do
      get "/api/backyards/#{backyard_article.id}"
    end

    it 'is expected to return 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to have title' do
      expect(response_json['backyard_article']['title']).to eq 'My cat is really spying on me'
    end

    it 'is expected to have a body' do
      expect(response_json['backyard_article']['body']).to eq 'My cat was flying yesterday'
    end

    it 'is expected to include written by Mr. fake' do
      expect(response_json['backyard_article']['written_by']).to eq 'Mr. Fake'
    end

    it 'is expected to show category' do
      expect(response_json['backyard_article']['theme']).to eq 'Haunted animals'
    end
  end

  describe 'unsuccessfully' do
    before do
      get '/api/backyards/123'
    end

    it 'is expected to return 404 status' do
      expect(response).to have_http_status 404
    end
    it 'is expected to have error message' do
      expect(response_json['error_message']).to eq "Couldn't find Article with 'id'=123"
    end
  end
end