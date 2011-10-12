require 'rspec'
require_relative '../../lib/polycene/restriction'

describe Restriction do

	it 'should be creatable' do
		restriction = Restriction.new 'name', 'type'
		restriction.should_not == nil
	end

	it 'should handle nil arguments when created' do
		lambda { Restriction.new nil, nil }.should raise_error
	end

end
