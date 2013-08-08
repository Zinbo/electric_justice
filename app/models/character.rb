class Character < ActiveRecord::Base
  belongs_to :user
  
  before_save { self.name = name.downcase }
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, character_is_in_guild: true
  
  def self.change_primary(char_params)
    transaction do      
      old_primary = Character.find_by_user_id_and_primary(char_params[:id], true)
      old_primary.primary = false
      new_primary = Character.find_by_id(char_params[:character])
      new_primary.primary = true
      old_primary.save
      new_primary.save
      return new_primary
    end
  end
  
end
