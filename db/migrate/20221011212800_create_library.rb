class CreateLibrary < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.boolean :public_library
      t.integer :employees
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP'}
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP'}
    end
  end
end
