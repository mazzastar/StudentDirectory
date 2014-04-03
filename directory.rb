TIOCGWINSZ = 0x40087468

def get_winsize
  str = [0, 0, 0, 0].pack('SSSS')
  if STDIN.ioctl(TIOCGWINSZ, str) >= 0
    rows, cols, xpixels, ypixels = str.unpack("SSSS")
    #rows, cols, xpixels, ypixels
    cols
  else
    puts "Unable to get window size"
  end
end

# amend input_students - break it into smaller methods, and allow input of cohort
puts "... #{ENV['COLUMNS'].inspect}"
def append_fields(hash)
	enterNewField = true
	while enterNewField
		print "Do you want to add another field to #{hash[:Name]}'s information? (y/n)\n"
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
	print "Please enter the name and cohort of the students\nUse the format: Name : Cohort. Cohort defaults to March.\n"
	print "To finish, just hit return twice\n"
	# create an empty array
	students = []
	# get first name
	name_and_cohort = gets.chomp.split(":")
	# while the name is not empty repeat this code
	while !name_and_cohort.empty? do
		# add the student hash to the array
		name_and_cohort.each {|ele| ele.strip!.capitalize!}
		name_and_cohort[1] = :March if name_and_cohort[1] == nil
		students << {:Name => name_and_cohort[0], :Cohort => name_and_cohort[1].to_sym}
		append_fields(students[-1])
		
		print "Now we have #{students.length} students\nPlease enter the name of the next student\n"
		name_and_cohort = gets.chomp.split(":")
	end
	#return the array of students
	students
end

def print_header()
	puts "The students of my cohort at Makers Academy".center(get_winsize)
	puts "-----------".center(get_winsize)
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
	hash[:Name].split('')[0] == "A" && hash[:Name].length<12
end


def print_list(list)
	max_index = list.length-1;
	i=0

	while i<=max_index
		if print_validation(list[i])
			centered_string =  "#{i+1}. #{hash_to_string(list[i])}"
			puts centered_string.center(get_winsize)
			#print "#{i+1}. #{hash_to_string(list[i])}\n"
		end 
		# print "#{i+1}. #{print_hash(list[i])}\n" if print_rule(list[i])
		i +=1

	end
end

def print_footer(list)
	puts "Overall, we have #{list.count} students.".center(get_winsize)
end



students = input_students
print_header
print_list(students)
print_footer(students)