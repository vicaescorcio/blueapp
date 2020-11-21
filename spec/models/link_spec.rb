require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  subject(:link) { Link.new(original: original) }

  let(:original) { 'https://example.com.br' }

  before { link.save }

  describe 'Validations' do
    context 'when there is no original url' do
      let(:original) {}

      it { expect(link).to be_invalid }
    end

    context 'when the original url has no valid format' do
      let(:original) { 'Joe doe' }

      it { expect(link).to be_invalid }
    end
  end

  describe 'Callbacks' do
    context 'when link is created a short url is generated' do
      it do
        expect(link.short_id).to_not be_nil
      end
    end
  end

  describe 'Encode link' do
    context 'when link is successfully encoded' do
      it { expect(link.encode).to match(/[^\s]/) }
    end
  end
end
