class SetDefaultValuesForReceivedMessagesColumns < ActiveRecord::Migration
  def change
    change_column :received_messages, :deleted, :boolean, :default => false
    change_column :received_messages, :read, :boolean, :default => false
  end
end
