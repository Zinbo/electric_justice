class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:index, :destroy]

  def index
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @characters = @user.characters.dup
  
    @character_responses = Hash.new
    @characters.each do |char|
      response = HTTParty.get('http://eu.battle.net/api/wow/character/Silvermoon/' + char.name + '?fields=items,feed,talents')
      @character_responses[char.id] = response
      if char.primary
        @characters.delete(char)
        @characters.unshift(char)
      end
    end
    
    @left_armour = ['head', 'neck', 'shoulder', 'back', 'chest', 'shirt',  'tabard', 'wrist']
    @right_armour = ['hands', 'waist', 'legs', 'feet', 'finger1', 'finger2', 'trinket1', 'trinket2']
    @bottom_armour = ['mainHand', 'offHand', 'ranged']
    
    @races = {1 => "human", 3 => "dwarf", 4 => "night-elf", 7 => "gnome", 11 => "draenei", 22 => "worgen", 25 => "pandaren"}
    @classes = {1 => "warrior", 2 => "paladin", 3 => "hunter", 4 => "rogue", 5 => "priest", 6 => "death-knight", 7 => "shaman", 8 => "mage", 9 => "warlock", 10 => "monk", 11 => "druid"}
    
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
end
