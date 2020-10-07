class CreateManagedSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :managed_subscriptions do |t|
      t.string :tenant_id, null: false
      t.string :subscription_id
      t.string :subscription_source
    end
  end
end
