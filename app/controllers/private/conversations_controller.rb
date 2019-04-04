class Private::ConversationsController < ApplicationController
  def create
        recipient_id = User.find(params[:user_id])
        conversation = Private::Conversation.new(sender_id: current_user.id, 
                                                 recipient_id: recipient_id)
        if conversation.save
          Private::Message.create(user_id: recipient_id, 
                                  conversation_id: conversation.id, 
                                  body: params[:message_body])
          respond_to do |format|
            format.js {render partial: 'layout/pages/success'}
          end
        else
          respond_to do |format|
            format.js {render partial: 'layout/pages/fail'}
          end
        end
    end
      
  private

  def add_to_conversations
        session[:private_conversations] ||= []
        session[:private_conversations] << @conversation.id
  end
  
  def already_added?
    session[:private_conversations].include?(@conversation.id)
  end
end
