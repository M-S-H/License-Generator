require 'rspec'
require_relative '../../lib/polycene/context'

describe Context do

	it 'should be creatable' do
		con = Context.new
		con.should_not == nil
	end

	it 'can load an ontology'
		
end
