class AddLinkedinInColumnToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_in, :string

  end
end
