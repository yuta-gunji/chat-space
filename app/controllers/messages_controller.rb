class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      redirect_to group_messages_path
    else
      render :index
    end
  end

  private

  def create_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
