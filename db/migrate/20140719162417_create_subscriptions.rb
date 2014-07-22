class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id
      t.integer :resource_id
      t.timestamps
    end

    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, :resource_id
    add_index :subscriptions, [:subscriber_id, :resource_id]
  end
end
