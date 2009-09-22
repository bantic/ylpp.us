class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer :shortening_id
      t.string :referer
      t.string :referer_host
      t.string :remote_ip
      t.string :user_agent
      t.timestamps
    end
  end

  def self.down
    drop_table :clicks
  end
end
