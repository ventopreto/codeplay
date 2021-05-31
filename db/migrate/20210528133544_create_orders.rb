class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.timestamps
    end
  end
end
