require 'rexml/document'
include REXML

class Restriction
	attr_accessor :values, :name, :type
	def initialize (name, type)
		@values = Array.new
		@name = name
		@type = type
	end

	def populate(doc, base)
		doc.elements.each ('//owl:NamedIndividual') { |e|
			e.elements.each ('rdf:type') { |s|
				if s.attributes["rdf:resource"] == base+@name
					@values << e.attributes["rdf:about"][base.length..e.attributes["rdf:about"].length]
				end
			}
		}
	end
end



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



class Context
	attr_accessor :entity_restrictions
	def initialize
		@entity_restrictions = Array.new
	end

	def populate (file)
		doc = Document.new (File.new(file))
		base = doc.elements[1].attributes["xml:base"] + '#'

		top_entities = []
		doc.elements.each ('//owl:Class') { |e| 
			e.elements.each ('rdfs:subClassOf') { |s|
				if s.attributes["rdf:resource"] == base+'MashupEntity'
					@entity_restrictions << EntityRestriction.new(e.attributes["rdf:about"][base.length..e.attributes["rdf:about"].length])
				end
			}
		}

		@entity_restrictions.each { |er| er.populate(doc, base) }
	end		
end

	






















