class AddDefaultToDismissed < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :dismissed, :boolean, default: false
  end
end
