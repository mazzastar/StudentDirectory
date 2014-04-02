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
		print "Now we have #{students.length} students\n"
		# get another name from the user
		name = gets.chomp
	end
	#return the array of students
	students
end

def print_header()
	print "The students of my cohort at Makers Academy\n"
	print "-----------\n"
end

def print_list(list)
	list.each do |student_info|
		print "#{student_info[:name]} (#{student_info[:cohort].to_s.capitalize} cohort)\n"
	end
end

def print_footer(list)
	print "Overall, we have #{list.count} students.\n\n"
end

students = input_students
print_header
print_list(students)
print_footer(students)