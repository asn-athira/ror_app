class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name      
      t.text :address
      t.string :phone
      t.string :email
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
