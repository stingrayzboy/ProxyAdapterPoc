require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before do
    Timecop.freeze(Time.new(2025, 1, 8, 15, 16, 44))
    FactoryBot.create(:blog, id: 1, title: "new blog", body: "new again")
  end

  after do
    Timecop.return
  end
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eql([{"body"=>"new again",
                                                 "created_at"=>"2025-01-08T15:16:44.000Z",
                                                 "id"=>1,
                                                 "title"=>"new blog",
                                                 "updated_at"=>"2025-01-08T15:16:44.000Z"}])
    end
  end

  describe "post /create" do
    let(:params) do
      {
        "blog":{
          "title": "new blog",
          "body":"new again again"
        }
      }
    end
    it "returns http success" do
      expect {
        post "/home/create", params: params
      }.to change { Blog.count }.by(1)
    end
  end

  describe "GET /bulk_create" do
    let(:params) do
      {
        "blogs": [
          {
            "title": "bew",
            "body": "sdfsdf"
          },
          {
            "title": "sdfsf",
            "body": "sdfsdf"
          },
          {
            "title": "sdfsf",
            "body": "sdfsdf"
          },
          {
            "title": "sdfsf",
            "body": "sdfsdf"
          }
        ]
      }
    end

    it "returns http success" do
      expect {
        post "/home/bulk_create", params: params
      }.to change { Blog.count }.by(4)
    end
  end

end
