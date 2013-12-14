# require 'spec_helper'
# require Rails.root.join('db','migrate','20131214150400_remove_non_null_constraint')

# describe RemoveNonNullConstraint do

  # describe '.up' do
    # it 'removes the non-null constraint on returned_on' do
      # described_class.up
      # expect(ActiveRecord::Base.connection.column_exists?('user_books','returned_on')).to be_true
    # end
  # end

  # describe '.down' do
    # it 'adds the non-null constraint on returned_on' do
      # described_class.down
      # expect(ActiveRecord::Base.connection.column_exists?('user_books','returned_on', null: false)).to be_true
    # end
  # end
# end
