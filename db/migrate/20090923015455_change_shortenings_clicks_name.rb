class ChangeShorteningsClicksName < ActiveRecord::Migration
  def self.up
    rename_column :shortenings, :clicks, :clicks_count
  end

  def self.down
    rename_column :shortenings, :clicks_count, :clicks
  end
end
