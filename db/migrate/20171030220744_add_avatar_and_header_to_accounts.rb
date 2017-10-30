class AddAvatarAndHeaderToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :avatar_data, :text
    add_column :accounts, :header_data, :text
  end
end
