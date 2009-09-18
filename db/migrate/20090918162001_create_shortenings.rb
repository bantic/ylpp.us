class CreateShortenings < ActiveRecord::Migration
  def self.up
    create_table :shortenings do |t|
      t.column :url, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :shortenings
  end
end
