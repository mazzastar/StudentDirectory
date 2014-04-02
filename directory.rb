def input_students
	print "Please enter the names of the students\n"
	print "To finish, just hit return twice\n"
	# create an empty array
	students = []
	# get first name
	name = gets.chomp
	# while the name is not empty repeat this code
	while !name.empty? do
		# add the student hash to the array
		students << {:name => name, :cohort => :november}
		

		enterNewField= true
		while enterNewField ==true# get another name from the user
			print "Do you want to add another field to #{:name}'s information? (y/n)\n"
			another_field = gets.chomp.to_s
			if another_field.capitalize == "Y"
				print "What is the name of the field?\n"
				new_field = gets.chomp
				print "What is the value?\n"
				new_val = gets.chomp
				students[-1][new_field.to_sym]=new_val
			else
				enterNewField = false
			end
		end
		print "Now we have #{students.length} students\nPlease enter the name of the next student\n"
		name = gets.chomp
	end
	#return the array of students
	students
end

def print_header()
	print "The students of my cohort at Makers Academy\n"
	print "-----------\n"
end

def print_hash(list_entry)
	list_entry.each do |key, value|
		print "#{key} : #{value} \t"
	end
	print "\n"
end

def print_rule(hash)
	hash[:name].split('')[0] == "A" && hash[:name].length<12
end


def print_list(list)
	max_index = list.length-1;
	i=0

	while i<=max_index
		print "#{i+1}. #{print_hash(list[i])} " if print_rule(list[i])
		i +=1
	end
end

def print_footer(list)
	print "Overall, we have #{list.count} students.\n\n"
end

students = input_students
print_header
print_list(students)
print_footer(students)