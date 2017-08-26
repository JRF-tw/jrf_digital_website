class CreateRecordsSubjects < ActiveRecord::Migration[4.2]
  def change
    create_table :records_subjects do |t|
      t.references :record, null: false
      t.references :subject, null: false
    end
    add_index(:records_subjects, [:record_id, :subject_id], name: "records_subjects_index", unique: true)
  end
end
