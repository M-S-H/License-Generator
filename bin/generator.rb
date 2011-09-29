require_relative '../lib/reader'


puts "Enter a License ID:"
id = gets.chomp
puts "\n\n"


context = Context.new
doc = Document.new '<?xml version="1.0" encoding="utf-8"?>'
doc.add_element 'license', {'id' => id}
doc.elements[1].add_element 'permissions'
doc.elements[1].elements[1].add_element 'restricted-activity', {'num' => 1, 'activity' => 'mashup'}


puts "Enter the ontology filename:"
file = gets.chomp
context.populate('./'+file)

t = 1

context.entity_restrictions.each { |er|
	
	doc.elements[1].elements[1].elements[1].add_element 'entity-restriction', {'type' => er.name }
		
	puts "\n----------------------------------------------------------\nSetting the #{er.name}\n----------------------------------------------------------"
	
	k = 1
	er.restrictions.each { |r|
		puts "   #{r.name} - #{r.type}"

		i = 1
		r.values.each { |v| puts "\t#{i}.  #{v}"; i+=1 }

		if r.type != 'SetProperty'
			puts "\nPlease Enter the the number corresponding to a property"
		else
			puts "\nPlease Enter a Value"
		end
		value = gets.chomp
		
		if r.type == 'ComparableProperty'
			puts "Allowable Functions are:    ==    !=    >=    <=    <    >    between()"
		end
		if r.type == 'EquitableProperty'
			puts "Allowable Functions are:    ==    !="
		end
		if r.type == 'SetProperty'
			puts "Allowable Functions are:    in()    not_in()"
		end
	
		puts "\nPlease Enter the Function"
		function = gets.chomp
		
		puts "\n\t***\n"
		doc.elements[1].elements[1].elements[1].elements[t].add_element 'restriction', {'property' => r.name, 'function' => function.to_s}	
		if r.type != 'SetProperty'	
			doc.elements[1].elements[1].elements[1].elements[t].elements[k].add_text r.values[value.to_i-1]
		else
			doc.elements[1].elements[1].elements[1].elements[t].elements[k].add_text value
		end
		k += 1
	}
	t+=1
}

puts "\n\n\n"
puts "----------------------------------------------------------------------------------------------------"
puts "Enter the License File Name"
lname = gets.chomp
formatter = Formatters::Pretty.new(4)
tempstring = String.new
formatter.write(doc, tempstring)
File.open(lname, 'w+') do |f|
	f.puts tempstring
end

























