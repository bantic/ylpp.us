class AddBotIndex < ActiveRecord::Migration
  def self.up
    add_index :clicks, :bot
  end

  def self.down
    remove_index :clicks, :bot
  end
end
