class AddImageUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image_url, :string, default: "https://clinicforspecialchildren.org/wp-content/uploads/2016/08/avatar-placeholder.gif"
  end
end
