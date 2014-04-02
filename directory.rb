def append_fields(hash)
	enterNewField = true
	while enterNewField
		print "Do you want to add another field to #{hash[:name]}'s information? (y/n)\n"
		another_field = gets.chomp.to_s.upcase
		if another_field == "Y"
			print "What is the name of the field?\n"
			new_field = gets.chomp
			print "What is the value?\n"
			new_val = gets.chomp
			hash[new_field.to_sym]=new_val
		else
			enterNewField = false
		end

	end

end

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
		append_fields(students[-1])
		#Deal with extra fields

		# enterNewField= true
		
		# while enterNewField ==true# get another name from the user
		# 	print "Do you want to add another field to #{:name}'s information? (y/n)\n"
		# 	another_field = gets.chomp.to_s
		# 	if another_field.capitalize == "Y"
		# 		print "What is the name of the field?\n"
		# 		new_field = gets.chomp
		# 		print "What is the value?\n"
		# 		new_val = gets.chomp
		# 		students[-1][new_field.to_sym]=new_val
		# 	else
		# 		enterNewField = false
		# 	end
		# end
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

def print_hash(hash)
	hash.each do |key, value|
		print "#{key} : #{value}\t"
	end
	print "\n"
end

def hash_to_string(hash)
	string=""
	hash.each do |key, value|
		string << "#{key} : #{value}  "
	end
	string
end	

def print_validation(hash)
	hash[:name].split('')[0] == "A" && hash[:name].length<12
end


def print_list(list)
	max_index = list.length-1;
	i=0

	while i<=max_index
		if print_validation(list[i])
			centered_string =  "#{i+1}. #{hash_to_string(list[i])}"
			puts centered_string.center(139)
			#print "#{i+1}. #{hash_to_string(list[i])}\n"
		end 
		# print "#{i+1}. #{print_hash(list[i])}\n" if print_rule(list[i])
		i +=1

	end
end

def print_footer(list)
	print "\nOverall, we have #{list.count} students.\n\n"
end

students = input_students
print_header
print_list(students)
print_footer(students)