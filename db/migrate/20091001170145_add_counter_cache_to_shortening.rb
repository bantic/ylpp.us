class AddCounterCacheToShortening < ActiveRecord::Migration
  def self.up
    add_column :shortenings, :all_clicks_count, :integer, :default => 0
    
    execute "update shortenings set all_clicks_count = clicks_count where 1"
  end

  def self.down
    remove_column :shortenings, :all_clicks_count
  end
end
