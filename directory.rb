
# first, we imported a list	
rawnameslist = %Q{Steve Musgrave
steve.musgrave@outlook.com
stephanmusgrave

Sroop Sunar
sroopsunar@hotmail.com
sroopsunar

Colin Marshall
colinbfmarshall@gmail.com

Josh Fail-Brown
josh@prrrfectfit.com

Louise Lai
louiselai88@gmail.com
louiselai88

Robin Doble
robindoble@gmail.com
robindoble

Alex Wong
aw12409@my.bristol.ac.uk
mavrm1

Scott Dimmock
scott123454@hotmail.com
scot123454

Muhanad Al-Rubaiee
muhanad40@gmail.com
m.rabbie

Shelley Hope
shelley894@btinternet.com

Will Hall
willhall88@hotmail.com
willhall88

Oliver Delevingne
odelevingne@gmail.com
odelevingne

Nico
nico@nicosaueressig.de
nico.saueressig

Apostolis
appostoliis@gmail.com
apostoliis

Stefania
stafaniaf.cardenas@gmail.com
jennifer_jentle

Robert Leon
llexi@hotmail.com
llexi.leon

Emma Williams
emma_williams1@hotmail.co.uk

Joey Wolf
halfdark000@gmail.com
urbanwolf_uk
@MisterJWolf (twitter)

Julie Walker
julieannwalker@hotmail.com}


#Splits a multiline string separated by paragraphs, then we split the extras again into individuals, before finally extracting 
#the name

#Specfic To Data in file
def parse_names(list)
	parsedList =[]
	nameslist = list.split("\n\n")
	nameslist.each do |str|
		x = str.split("\n")
		parsedList.push(x[0])	
	end
	parsedList

end

def create_student_array_by_name_array(names, cohort=:March)
	students =[]
	names.each do |name|
		students.push(create_student_hash(name, cohort))
	end
	students

end
#End


#Iterate through the names and list them.

def create_student_hash(student, cohort)
	student_info = {:name => student, :cohort => cohort.to_sym}
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

#Data to Process, won't need later on
names = parse_names(rawnameslist)
student_array =  create_student_array_by_name_array(names)


print_header
print_list(student_array)
print_footer(student_array)


