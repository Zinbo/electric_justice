class MailboxesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:show]
  
  def show
    @inbox_messages = current_user.received_messages_as_recipient.order("created_at DESC")
    
    @trash_messages = @inbox_messages.select{ |message| message.deleted}
    @inbox_messages=  @inbox_messages - @trash_messages
    @outbox_messages = current_user.sent_messages_as_sender.order("created_at DESC")
  end
  
  def received_message
    @message = ReceivedMessage.find(params[:id])
    if !@message.read
      @message.read = true
      @message.save
    end
  end
  
  def sent_message
    @message = SentMessage.find(params[:id])
  end
  
  def compose_message
    @message = SentMessage.new
    @character = Character.new
    @character.name = params[:recipient]
    
  end
  
  def send_message
    
    puts params
    
    @character = Character.new(params[:character])
    
    @message = SentMessage.new(subject: params[:sent_message][:subject], body: params[:sent_message][:body], sent_sender: current_user)
    recipient = Character.find_by_name(@character.name.downcase)
    
    if recipient.nil?
      @message.errors["Recipient"] << " doesn't exist"
      render 'compose_message'
    else
      @message.sent_recipient = recipient.user
      @message.save
      
      message_to_receive = ReceivedMessage.new(subject: params[:sent_message][:subject], body: params[:sent_message][:body], received_recipient: recipient.user, received_sender: current_user)
      message_to_receive.save
      
      flash.now[:success] = "Message sent"
      
      show
      render 'show'
    end
    
  end

  def delete_selected_inbox
    
    message_ids = params[:selected_messages]
    message_ids.each do |id|
      message = ReceivedMessage.find(id)
      message.deleted = true
      message.save
    end

    flash[:success] = "Message(s) moved to trash"
    redirect_to mailbox_path
    
  end
  
  def delete_selected_outbox

    message_ids = params[:selected_messages]
    message_ids.each do |id|
      message = SentMessage.find(id)
      message.destroy
    end
    
    flash[:success] = "Message(s) deleted"
    redirect_to mailbox_path
    
  end
  
  def delete_selected_trash

    message_ids = params[:selected_messages]
    message_ids.each do |id|
      message = ReceivedMessage.find(id)
      message.destroy
    end
    
    flash[:success] = "Message(s) deleted"
    redirect_to mailbox_path
    
  end
  
end
