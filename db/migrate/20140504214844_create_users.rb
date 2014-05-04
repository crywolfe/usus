class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :city
      t.string :state
      t.string :zip
      t.string :profile_pic_url
      t.string :current_position_title
      t.string :employment_status
      t.string :company_name
      t.string :linkedin_profile_link
      t.boolean :enterprise_status, default: false
      t.boolean :admin_status, default: false
      t.timestamps

    end
  end
end
