require 'rails_helper'

RSpec.describe "Links", type: :request do

  describe 'POST /links' do
    let(:link_params) do
      { original: 'https://ww.exampel.com.br' }
    end

    before do
      post links_path, params: link_params
    end

    context 'valid arguments' do
      it { expect(response).to have_http_status(:created) }
      it { expect(json.dig('link', 'short')).to_n(:created) }
    end
  end
end
