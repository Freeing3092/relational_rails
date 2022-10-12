class CreateBook < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :library_id
      t.string :name
      t.boolean :checked_out
      t.integer :pages
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP'}
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP'}
    end
  end
end
