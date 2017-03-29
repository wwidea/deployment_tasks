ActiveRecord::Schema.define do
  self.verbose = false

  create_table :deployment_tasks, id: false, force: true do |t|
    t.string :version
  end
end
