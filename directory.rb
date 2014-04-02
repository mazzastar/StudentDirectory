def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	# create an empty array
	students = []
	# get first name
	name = gets.chomp
	# while the name is not empty repeat this code
	while !name.empty? do
		# add the student hash to the array
		students << {:name => name, :cohort => :november}
		puts "Now we have #{students.length} students"
		# get another name from the user
		name = gets.chomp
	end
	#return the array of students
	students
end

def print_header()
	puts "The students of my cohort at Makers Academy"
	puts "-----------"
end

def print_list(list)
	list.each do |student_info|
		puts "#{student_info[:name]} (#{student_info[:cohort]} cohort)"
	end
end

def print_footer(list)
	puts "Overall, we have #{list.count} students."
end

students = input_students
print_header
print_list(students)
print_footer(students)