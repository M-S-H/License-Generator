require_relative '../lib/polycene/restriction'
require_relative '../lib/polycene/entity_restriction'
require_relative '../lib/polycene/context'
require_relative '../lib/polycene/license'

print "Enter a License ID:  "
id = gets.chomp
license= License.new (id)

print "\nEnter the ontology filename:  "
file = gets.chomp
license.context.populate ('../etc/rdf/' + file)

t = 1

license.context.entity_restrictions.each { |er|
	license.doc.elements[1].elements[1].elements[1].add_element 'entity-restriction', {'type' => er.name }
	puts "\n-------------------------------------\n   #{er.name}\n-------------------------------------\n"

	values = []; functions = []; lnames = []
	er.restrictions.each { |r|
	lnames << r.name
		if r.type != 'SetProperty'
			r.print_values
			print "\n   Please enter one of the values litsted above:  "
			values << gets.chomp
			print "\n   Please enter an allowed function:  "
			functions << gets.chomp
		else
			puts "   Number of #{r.name} restrictions:  "
			num = gets.chomp.to_i
			num.times do
				r.print_values
				print "\n   Please enter a value:  "
				values << gets.chomp
				print "\n   Please enter an allowed fucntion:  "
				functions << gets.chomp
				puts "\n"
			end
		end
		puts "\n\n"
	}
	license.add_elements values, functions, lnames, t
	t += 1
}

puts "\n-------------------------------------\n   AOI-Restriction\n-------------------------------------\n"
print "\n     Does this license have a aoi restriction? (yes/no)\n\n     Please enter a value:  "
aoi = gets.chomp
license.add_aoi_restriction (aoi)
print "\n\n-----------------------------------------\n   Please enter a name for the file:  "
fname = gets.chomp
license.build_license (fname)





