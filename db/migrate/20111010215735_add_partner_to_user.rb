class AddPartnerToUser < ActiveRecord::Migration
  def up
    add_column :users, :partner_id, :integer, :null => false
    MigrationHelpers.add_foreign_key(:users, :partner_id, :partners)
  end

  def down
    MigrationHelpers.remove_foreign_key(:users, :partner_id)
    remove_column :users, :partner_id
  end
end
