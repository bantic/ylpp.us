class CreateShortenings < ActiveRecord::Migration
  def self.up
    create_table :shortenings do |t|
      t.column :url, :string
      t.column :hash_key, :string
      t.column :custom, :boolean, :default => false
      t.column :clicks, :integer, :default => 0
      t.timestamps
    end
    add_index :shortenings, :id
    add_index :shortenings, :hash_key, :unique => true
  end

  def self.down
    drop_table :shortenings
  end
end
