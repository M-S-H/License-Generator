require 'rexml/document'
include REXML

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
