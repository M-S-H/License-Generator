require 'rexml/document'

require_relative './restriction'


include REXML

class EntityRestriction
	attr_accessor :restrictions, :name
	def initialize (name)
		@name = name
		@restrictions = Array.new
	end

	def populate (doc, base)
		@tempname
		@temptype
		doc.elements.each ('//owl:Class') { |e|
			e.elements.each ('rdfs:subClassOf') { |s|
				case s.attributes["rdf:resource"]
					when base+@name
						@tempname = e.attributes["rdf:about"][base.length..e.attributes["rdf:about"].length]
					when base+'ComparableProperty'
						@temptype = 'ComparableProperty'
					when base+'EquitableProperty'
						@temptype = 'EquitableProperty'
					when base+'SetProperty'
						@temptype='SetProperty'
				end
			}
			
			if @tempname != nil && @temptype != nil
				@restrictions << Restriction.new(@tempname, @temptype)
			end

			@tempname = nil
			@temptype = nil
		}
		
		@restrictions.each { |r| r.populate(doc, base) }
	end
end
