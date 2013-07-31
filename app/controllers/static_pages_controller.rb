
class StaticPagesController < ApplicationController
  
  before_filter :authenticate_user!, only: [:voice_server_details]
  
  def home
  end
  
  def gallery
  end
  
  def progression
    response = HTTParty.get('http://eu.battle.net/api/wow/guild/Silvermoon/Electric%20Justice?fields=achievements')
    criteria = response['achievements']['criteria']
    acheivements = response['achievements']
    thunder_king_normal_criteria = [23072, 23073, 23074, 23075, 23076, 23077, 23078, 23079, 23080, 23081, 23082, 23083]
    heart_of_fear_normal_criteria = [19489, 19490, 19491, 19492, 19493]
    toes_normal_criteria = [19651, 19652, 19494, 19495]
    mogu_shan_normal_criteria = [22384, 19485, 19486, 19487, 19114, 19488]
    
    @no_of_thunder_king_bosses = thunder_king_normal_criteria.size
    @thunder_king_progression = @no_of_thunder_king_bosses - (thunder_king_normal_criteria - criteria).size
    
    @no_of_heart_of_fear_bosses = heart_of_fear_normal_criteria.size
    @heart_of_fear_progression = @no_of_heart_of_fear_bosses - (heart_of_fear_normal_criteria - criteria).size
    
    @no_of_toes_bosses = toes_normal_criteria.size
    @toes_progression = @no_of_toes_bosses - (toes_normal_criteria - criteria).size 
    
    @no_of_mogu_shan_bosses = mogu_shan_normal_criteria.size
    @mogu_shan_progression = @no_of_mogu_shan_bosses - (mogu_shan_normal_criteria - criteria).size 
    
  end
  
  def roster
    response = HTTParty.get('http://eu.battle.net/api/wow/guild/Silvermoon/Electric%20Justice?fields=members')
    @guildMembers = response['members']
    @races = {1 => "human", 3 => "dwarf", 4 => "night-elf", 7 => "gnome", 11 => "draenei", 22 => "worgen", 25 => "pandaren"}
    @classes = {1 => "warrior", 2 => "paladin", 3 => "hunter", 4 => "rogue", 5 => "priest", 6 => "death-knight", 7 => "shaman", 8 => "mage", 9 => "warlock", 10 => "monk", 11 => "druid"}
    @gender = {0 => "male", 1 => "female"}
    @rank = {0 => "Guild Master", 1 => "Officer", 2 => "Raider", 3 => "Social"}
  end
  
  def voice_server_details

  end
  
  def request_bank_items
  end
  
end
