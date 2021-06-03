class AddStudentRefToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :student, null: false, foreign_key: true
  end
end
