 class PollsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:index]
  
  def index
    @poll = Poll.order("created_at").last
    @poll = Poll.find_by_id(@poll.id, :include => { :answers => :responses } )
    already_answered = false
    @poll.responses.each do |r|
      if r.user == current_user
        already_answered = true
        break
      end
    end
    if already_answered
      @no_of_responses = []
      @poll.answers.each do |a|
        
        @no_of_responses << a.responses.count
      end

      gon.answers = @poll.answers.map(&:answer)

      gon.poll = @poll
      gon.no_of_responses = @no_of_responses
      render 'graph'
    else
      @response = Response.new
      render 'index'
    end
    
  end
    
  
  def answer
    answer = Answer.find(params[:answer])
    @response = Response.new(:answer => answer, :user => current_user)
    if @response.save
      flash.now[:success] = "Thank you for your input!"
    else
      flash.now[:error] = "SOMETHING TERRIBLE HAS HAPPENED"      
    end
    index
  end
  
  def older
    polls = Poll.order("created_at DESC")
    polls.shift
    
    if polls.count > 1
      list_of_no_of_responses = []
      list_of_answers = []
      polls.each do |p|
        
        no_of_responses = []
        answers = []
        
        p.answers.each do |a|
          answers << a.answer
          no_of_responses << a.responses.count
        end
        
        list_of_answers << answers
        list_of_no_of_responses << no_of_responses
      end
      
      gon.polls = polls
      gon.list_of_no_of_responses = list_of_no_of_responses
      gon.list_of_answers = list_of_answers 
     
     @no_of_polls = polls.count
      
    end
  end
  
  def new
    @poll = Poll.new
  end
  
  def create
    poll = Poll.new(params[:poll])
    poll.save
    flash[:success] = "poll saved"
    redirect_to polls_path
  end
  
  def edit
    @poll = Poll.find(params[:id])
  end
  
  def update
    @poll = Poll.find(params[:id])
    @poll.update_attributes(params[:poll]) 
    params[:poll][:answers_attributes].each do |a|
      if a[1][:_destroy] == 1.to_s
        answer = Answer.find(a[1][:id])
        answer.destroy
      end
    end
    flash[:success] = "poll edited"
    redirect_to polls_path
  end
  
  def destroy
    Poll.find(params[:id]).destroy
    flash[:success] = "Poll deleted."
    redirect_to polls_path
  end
  
end
