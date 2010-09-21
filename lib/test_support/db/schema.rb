require 'sniff/database'

Sniff::Database.define_schema do
  create_table "computation_records", :force => true do |t|
    t.float  'compute_time'
  end
end
