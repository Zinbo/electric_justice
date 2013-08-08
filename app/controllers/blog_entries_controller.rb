class BlogEntriesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :create]
  
  def overview
    @blog_entries = BlogEntry.paginate(:page => params[:page]).order("updated_at DESC")
  end
  
  def new
    @entry = BlogEntry.new()
  end
  
  def create
    entry = BlogEntry.create(params[:blog_entry])
    entry.user = current_user
    entry.save
    
    redirect_to overview_path
  end
  
  def edit
    @entry = BlogEntry.find(params[:id])
  end
  
  def update
    puts "update params: "
    puts params
    entry = BlogEntry.find(params[:id])
    entry.entry = params[:blog_entry][:entry]
    
    entry.save
    
    redirect_to overview_path
  end
  
end
