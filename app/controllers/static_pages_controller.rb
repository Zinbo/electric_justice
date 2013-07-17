
class StaticPagesController < ApplicationController
  
  def home
  end
  
  def gallery
  end
  
  def progression
  end
  
  def roster
    response = HTTParty.get('http://eu.battle.net/api/wow/guild/Silvermoon/Electric%20Justice?fields=members')
    @guildMembers = response['members']
    @races = {1 => "human", 3 => "dwarf", 4 => "night-elf", 7 => "gnome", 11 => "draenei", 22 => "worgen", 25 => "pandaren"}
    @classes = {1 => "warrior", 2 => "paladin", 3 => "hunter", 4 => "rogue", 5 => "priest", 6 => "death-knight", 7 => "shaman", 8 => "mage", 9 => "warlock", 10 => "monk", 11 => "druid"}
    @gender = {0 => "male", 1 => "female"}
  end
  
  def voice_server_details

  end
  
  def request_bank_items
  end
  
  def polls
  end
  
end
