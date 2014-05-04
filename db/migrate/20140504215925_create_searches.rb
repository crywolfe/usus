class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :position 
      t.string :city
      t.string :state
      t.string :zip
      t.string :industry
      t.string :company
      t.references :user
      t.timestamps

    end
  end
end
