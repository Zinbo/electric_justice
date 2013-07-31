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
      no_of_responses = []
      @poll.answers.each do |a|
        no_of_responses << a.responses.count
      end
      
      puts "Showing chart...."
      
      @chart = LazyHighCharts::HighChart.new('graph') do |f|
         f.title({ :text=> @poll.question})
         f.options[:yAxis] = {:title => {:text => "Responses"}, :allowDecimals => false}
         f.options[:xAxis] = {:title => {:text => "Answers"}, :categories => @poll.answers.map(&:answer)}
         f.series(:type=> 'column',:name=> 'responses',:data=> no_of_responses)
      end
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
    
    @charts = []
    if polls.count > 1
      polls.each do |p|
        no_of_responses = []
        p.answers.each do |a|
          no_of_responses << a.responses.count
        end

        @charts << LazyHighCharts::HighChart.new('graph') do |f|
          f.title({ :text=> p.question})
          f.options[:yAxis] = {:title => {:text => "Responses"}, :allowDecimals => false}
          f.options[:xAxis] = {:title => {:text => "Answers"}, :categories => p.answers.map(&:answer)}
          f.series(:type=> 'column',:name=> 'responses',:data=> no_of_responses)
        end
      end
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
  
end
