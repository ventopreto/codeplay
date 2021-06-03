class RemoveUserRefFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :user, null: false
  end
end
