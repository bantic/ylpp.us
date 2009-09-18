class CreateShortenings < ActiveRecord::Migration
  def self.up
    create_table :shortenings do |t|
      t.column :url, :string
      t.timestamps
    end
    add_index :shortenings, :id
  end

  def self.down
    drop_table :shortenings
  end
end
