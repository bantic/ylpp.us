class AddBotToClick < ActiveRecord::Migration
  def self.up
    add_column :clicks, :bot, :boolean, :default => false
  end

  def self.down
    remove_column :clicks, :bot
  end
end
