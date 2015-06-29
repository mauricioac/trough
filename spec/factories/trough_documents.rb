FactoryGirl.define do
  factory :trough_document, :class => 'Trough::Document' do
    file { File.open('spec/files/image.png') }
  end
end
