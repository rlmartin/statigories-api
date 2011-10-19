class AddPartnerColumns < ActiveRecord::Migration
  def change
    add_column :partners, :name, :string
    add_column :partners, :username, :string
    add_index :partners, :username, :unique => true
  end
end
