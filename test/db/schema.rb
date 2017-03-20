ActiveRecord::Schema.define do
  self.verbose = false

  create_table :deployment_task, :force => true do |t|
    t.string :version
  end
end
