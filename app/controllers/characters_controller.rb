class CharactersController < ApplicationController
  include ActiveModel::ForbiddenAttributesProtection
  
  before_filter :authenticate_user!
  
  def primary
      character = Character.change_primary(params)
      flash[:success] = character.name.titleize + " is now the primary character"
      redirect_to alts_path
  end
  
  def delete
    char_to_destroy = Character.find_by_id(params[:character])
    char_to_destroy.destroy;
    flash[:success] = char_to_destroy.name.titleize + " deleted"
    redirect_to alts_path
  end
  
  def show
    @character = Character.new
    @characters = Character.find(:all, :conditions => {:user_id => params[:id]})
  end
  
  def update
    @character = Character.new(char_params)
    @character.user = current_user
    
    puts @character.name
    puts char_params
    
    if @character.save
      flash[:success] = @character.name.titleize + " added"
      redirect_to alts_path
    else
      @characters = Character.find(:all, :conditions => {:user_id => params[:id]})
      render 'show'
    end
  end
  
  private
  
    def char_params
      params.require(:character).permit(:name)
    end
  
end
