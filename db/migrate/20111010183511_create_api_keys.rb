class CreateApiKeys < ActiveRecord::Migration
  def up
    create_table :api_keys do |t|
      t.integer :partner_id, :null => false
      t.string :public, :limit => 20
      t.string :private, :limit => 40

      t.timestamps
    end
    MigrationHelpers.add_foreign_key(:api_keys, :partner_id, :partners)
    add_index :api_keys, :public, :unique => true
  end

  def down
    MigrationHelpers.remove_foreign_key(:api_keys, :partner_id)
    drop_table :api_keys
  end
end
