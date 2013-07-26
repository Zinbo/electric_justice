class CharacterIsInGuildValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.blank?
      response = HTTParty.get('http://eu.battle.net/api/wow/character/Silvermoon/' + value + '?fields=guild')
      if response['status'] == 'nok' || response['guild'].blank? || response['guild']['name'] != 'Electric Justice'
        record.errors[attribute] << "isn't in guild"  
      end
    end
  end
end