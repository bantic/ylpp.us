class AddCountryAndCityToClicks < ActiveRecord::Migration
  def self.up
    add_column :clicks, :country, :string
    add_column :clicks, :city, :string
    add_column :clicks, :region, :string
  end

  def self.down
    remove_column :clicks, :country
    remove_column :clicks, :city
    remove_column :clicks, :region
  end
end
