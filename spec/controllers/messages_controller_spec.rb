require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user, :for_controller) }
  let(:group) { build(:group, id: 1) }
  describe 'GET #index' do
    context "when user log-in" do
      login_user
      it "assigns the requested message to @message" do
        get :index, params: { group_id: group.id }
        expect(assigns(:message)).to be_a_new(Message)
      end
      it "assigns the requested group to @group" do
        get :index, params: { group_id: group.id }
        expect(assigns(:group)).to eq group
      end
      it "assigns the requested groups to @groups" do
        groups = user.groups
        get :index, params: { group_id: groups.first.id }
        expect(assigns(:groups)).to eq groups
      end
      it "assigns the requested messages to @messages" do
        messages = user.groups.first.messages
        get :index, params: { group_id: user.groups.first.id }
        expect(assigns(:messages)).to eq messages
      end
      it "renders the index tempalte" do
        get :index, params: { group_id: group.id }
        expect(response).to render_template :index
      end
    end
    context "when user not log-in" do
      it "redirect to sign-up view" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe 'POST #create' do
    context "when user log-in" do
      let(:firts_group) { user.groups.first }
      login_user
      it "saves the new message in the database" do
        expect{
          post :create, params: { group_id: firts_group.id, message: attributes_for(:message) }
        }.to change(Message, :count).by(1)
      end
      it "redirects to the messages#index" do
        post :create, params: { group_id: firts_group.id, message: attributes_for(:message) }
          expect(response).to redirect_to group_messages_path
      end
      it "doesn't save the new message in the database" do
        expect{
          post :create, params: { group_id: firts_group.id, message: attributes_for(:message, body: nil, image: nil) }
        }.not_to change(Message, :count)
      end
      it "renders the index tempalte when can't save the new message" do
        post :create, params: { group_id: firts_group.id, message: attributes_for(:message, body: nil, image: nil) }
        expect(response).to render_template :index
      end
    end
    context "when user not log-in" do
      it "redirect to sign-up view" do
        post :create, params: {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
