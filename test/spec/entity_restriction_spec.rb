require 'rspec'
require_relative '../../lib/polycene/entity_restriction'

describe EntityRestriction do

  it 'should be creatable' do
    er = EntityRestriction.new 'name'
    er.should_not == nil
  end
  
  it 'should handle nil ctor args' do
    er = EntityRestriction.new  nil
    er.should_not == nil
    er.name.should == nil
  end
  
  context 'with a well defined ontology' do     #what a 'well defined ontology' is has not been determined
    it 'should process restrictions'
  end
  
  context 'with a incorrect ontology' do
    it 'should fail fast'
  end

end
