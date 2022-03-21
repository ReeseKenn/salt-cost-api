require 'rails_helper'

RSpec.describe User, type: :model do
  it '有 email' do
    user = User.new email: 'salt@1.com'
    expect(user.email).to eq 'salt@1.com'
  end
end