class MessagesController < ApplicationController
  before_action :set_group_set_messages, only: [:index, :create]

  def index
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      redirect_to group_messages_path
    else
      flash.now[:alert] = "メッセージを入力してください"
      render :index
    end
  end

  private

  def create_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group_set_messages
    @group = Group.find(params[:group_id])
    @messages = @group.messages.includes(:user)
  end
end
