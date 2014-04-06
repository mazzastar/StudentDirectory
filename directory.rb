TIOCGWINSZ = 0x40087468
def new_chomp(string)
	string.gsub!("\n", "")
end

def valid_months(input_symbol)
	months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
	months.include?(input_symbol)
end

def has_student?(student_list)
	!student_list.empty?
end

def get_winsize
  str = [0, 0, 0, 0].pack('SSSS')
  if STDIN.ioctl(TIOCGWINSZ, str) >= 0
    rows, cols, xpixels, ypixels = str.unpack("SSSS")
    cols
  else
    puts "Unable to get window size"
  end
end

#Load File
def readfile(file)
	file_name = file #"students.csv"
	txt = File.open(file_name)
	student_array = txt.read().split("\n")
	txt.close()
	# puts student_array.inspect
	parsedValues = student_array.map do |student|
		student.split(",").map{|field_value| field_value.strip}
	end 
end

def openWriteFileStream(file)
	file_name = file
	txt = File.open(file_name, 'a')
end

def appendFile(fileStream, line)
	fileStream.write("\n")
	fileStream.write(line)
end

def closeWriteFileStream(fileStream)
	fileStream.close()
end

def addLineToFile(file, line)
	fs = openWriteFileStream(file)
	appendFile(fs, line)
	closeWriteFileStream(fs)
end

def add_defaults(hash_array, defaults_values)
	default_keys = defaults_values.keys.map{|key| key.to_sym}
	hash_array.each do|hash| 
		default_keys.each{|key| hash[key]=defaults_values[key] if hash[key].nil? }
	end
end

def header_extract(parsedValues)
	headers =  parsedValues.first.map{|fields| fields.capitalize.to_sym}
end

def data_extract(parsedValues)
	data = parsedValues[1...(parsedValues.length)]
end

def hashup_data(headers, data)
	#Zip Array
	hash_array = data.map do |y|
		Hash[headers.zip(y)]
	end	

end

def process_file(file, defaults_values)
	parsedValues = readfile(file)
	headers= header_extract(parsedValues)
	data = data_extract(parsedValues)
	hash_array = hashup_data(headers, data)	
	add_defaults(hash_array, defaults_values)
end


# amend input_students - break it into smaller methods, and allow input of cohort
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

def cleanup(string)
	string.strip!
	string.capitalize!
	string
end

def get_info
	x = new_chomp(gets)
	x.split(":").map{|field| cleanup(field)}
end

def is_plural?(value)
	value > 1
end


def print_current_students(students)
	str = "Currently we have #{students.length} student#{'s' if is_plural?(students.length)}\nPlease enter the name of the next student\n"
	print str
end

def hash_to_csv_string(hash, order)
	string_array = []
	order.each do |key|
		string_array<<hash[key]
	end
	string_array.join(",")
end

def input_students(existing_students, file)
	months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
	order =[:Name, :Email, :Skype]

	print "Please enter the name and cohort of the students\nUse the format: Name : Cohort. Cohort defaults to March.\n"
	print "To finish, just hit return twice\n"
	# create an empty array
	students = existing_students
	# get first name
	name_and_cohort = get_info
	# while the name is not empty repeat this code
	while !name_and_cohort.empty? do
		# add the student hash to the array
		name_and_cohort << "March" if name_and_cohort[1].nil?
		#if !months.include?(name_and_cohort[1].to_sym)
		if !valid_months(name_and_cohort[1].to_sym)
			puts "Unrecognised cohort (should be a month)."
			print_current_students(students)
			name_and_cohort = get_info
			next
		end
		students << {:Name => name_and_cohort[0], :Cohort => name_and_cohort[1].to_sym}
		append_fields(students[-1])
		puts hash_to_csv_string(students[-1], order)
		line = hash_to_csv_string(students[-1], order)
		addLineToFile(file, line)



		print_current_students(students)
		name_and_cohort = get_info

	end
	if !has_student?(students)
		puts "No students! Starting again Press Ctrl-C to exit".center(get_winsize, "*")
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
		end 
		i +=1

	end
end


def print_footer(list)
	puts "Overall, we have #{list.count} student#{'s' if is_plural?(list.count)}.".center(get_winsize)
end

def extract_from(students, cohort_sym)
	results = students.select do |student|
		student[:Cohort]==cohort_sym
	end
	results
end

# Adjust this to take input of existing data.
file = "students.csv"
defaults_values = {Cohort: :March, Email: "no Email", Skype: "no user"}


existing_students = process_file(file, defaults_values)

students = input_students(existing_students, file)

while !has_student?(students)
	students = input_students
end

print "Which cohort would you like to filter by?\n> "
cohort_sym= (cleanup(gets.chomp)).to_sym
print_header
#get cohort choice
chosen_students = extract_from(students,cohort_sym)
print_list(chosen_students)
print_footer(students)
