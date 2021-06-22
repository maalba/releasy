class AddDismissedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :dismissed, :boolean, default: false
  end
end
