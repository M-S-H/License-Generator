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
