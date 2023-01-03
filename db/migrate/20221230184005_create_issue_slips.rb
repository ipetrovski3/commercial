class CreateIssueSlips < ActiveRecord::Migration[7.0]
  def change
    create_table :issue_slips do |t|
      t.integer :number
      t.date :date
      t.references :customer, null: false, foreign_key: true
      t.string :received_by
      t.string :licence_plate
      t.integer :invoice_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
