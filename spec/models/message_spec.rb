require 'rails_helper'

describe Message do
  describe '#create' do

    it "is valid with a body" do
      message = build(:message, image: "")
      expect(message).to be_valid
    end

    it "is valid with a image" do
      message = build(:message, body: "")
      expect(message).to be_valid
    end

    it "is valid with a body & a image" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without message" do
      message = build(:message, body: "", image: "")
      expect(message).not_to be_valid
    end

    it "is invalid without a user_id" do
      expect{ create(:message, user_id: "") }.to raise_error(ActiveRecord::StatementInvalid)
     end

    it "is invalid without a group_id" do
      expect{ create(:message, group_id: "") }.to raise_error(ActiveRecord::StatementInvalid)
    end
  end
end

