require 'rails_helper'

module Trough
  RSpec.describe Document, type: :model do
    subject{ FactoryGirl.build(:trough_document) }

    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'requires a file' do
      document_without_file = FactoryGirl.build(:trough_document, file: '')
      expect(document_without_file).to_not be_valid
    end
  end
end
