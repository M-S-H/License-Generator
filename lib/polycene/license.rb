require 'rexml/document'
require_relative './context'
require_relative './restriction'
require_relative './entity_restriction'
include REXML


class License
	attr_reader :doc, :context

	def initialize (id)
		@context = Context.new
		@doc = Document.new '<?xml version="1.0" encoding="utf-8"?>'
		@doc.add_element 'license', {'id' => id}
		@doc.elements[1].add_element 'permissions'
		@doc.elements[1].elements[1].add_element 'restricted-activity', {'num' => 1, 'activity' => 'mashup'}
	end

	def add_elements (values, functions, rname, t)
		i = 0
		k = 1
		values.length.times do
			@doc.elements[1].elements[1].elements[1].elements[t].add_element 'restriction', {'property' => rname[i], 'function' => functions[i]}
			@doc.elements[1].elements[1].elements[1].elements[t].elements[k].add_text values[i]
			i += 1
			k += 1
		end
	end

	def build_license (name)
		formatter = Formatters::Pretty.new(4)
		tempstring = String.new
		formatter.write(doc, tempstring)
		File.open('../etc/licenses/' + name + '.xml', 'w+') do |f|
			f.puts tempstring
		end
	end
end


