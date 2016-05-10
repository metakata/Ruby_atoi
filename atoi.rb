# The Atoi (Ascii TO Integer) class contain methods to analyze a 
# string containing integers and return the first grouping of integers 
# as an integer data type.  The conversion will stop upon hitting the first
# non-integer ascii character.  
#
# Author::		Carl Andrew Menning 
# Version::		0.0.1
# License::		Distributes under the same terms as Ruby

# The Atoi class converts a string containing integers
# and returns the first grouping of integers 
# as an integer data type.
class Atoi
	@@ascii_hash = {
		'0' => 0,
		'1' => 1,
		'2' => 2,
		'3' => 3,
		'4' => 4,
		'5' => 5,
		'6' => 6,
		'7' => 7,
		'8' => 8,
		'9' => 9
	}
	
	# The convert method is the main method to analyze a string containing integers
	# and return an integer data type containing the first grouping of numbers.
	#
	# * *Args*	  :
	#	- +num_str+ -> string containing integers to be converted
	# * *Returns* :
	# 	- if ascii numbers are present, it returns the first grouping of numbers as an integer data type
	#	- if no ascii numbers are present, it returns nil
	# * *Raises*  :
	#	- +ArgumentError+ -> if input "num_str" parameter is not String type
	def convert(num_str)
		raise ArgumentError, "Input is required to be a String" unless num_str.is_a?(String)
		first_group = false
		resulting_int = nil
		num_str.each_char do |character|
			if is_digit?(character)
				first_group = true
				resulting_int = 0 unless resulting_int != nil
				resulting_int = shift_integer_positions(resulting_int)
				resulting_int += ascii_lookup(character)
			elsif (first_group==true)
				break
			end
		end
		return resulting_int
	end

	# The shift_integer_positions method is the method used to shift current 
	# integers left by one to make room for the new "ones" integer.
	# For example:
	#	- 23 would become 230
	#	- 358209 would become 3582090
	#
	# * *Args*	  :
	#	- +old_number+ -> current integer to be shifted by 10x
	# * *Returns* :
	# 	- the shifted adjusted number with 0 in the ones integer position and all other integers shifted left by one placement
	# * *Raises*  :
	#	- +ArgumentError+ -> if input "old_number" is not an integer of Fixnum or Bignum data type
	def shift_integer_positions(old_number)
		adjusted_number = 0 if old_number.is_a?(Fixnum) || old_number.is_a?(Bignum)
		raise ArgumentError, "Input is required to be of type Fixnum or Bignum" unless adjusted_number != nil
		for x in 1..10 do
			adjusted_number += old_number
		end
		return adjusted_number
	end
	
	# The is_digit? method is the method used to confirm if current  
	# ascii string character has a corresponding integer defined using
	# the class hash variable @@ascii_hash.  The current version searches
	# for 0-9.
	#
	# * *Args*	  :
	#	- +character+ -> ascii character to check
	# * *Returns* :
	# 	- true if character is part of the ascii digits 0-9, otherwise false
	# * *Raises*  :
	#	- This method contains no additional errors
	def is_digit?(character)
		return @@ascii_hash.key?(character)
	end
	
	# The ascii_lookup method uses the class variable @@ascii_hash and   
	# returns the Fixnum integer that corresponds to the ascii digits 
	# contained within 0-9.  For all other inputs, it returns nil.
	#
	# * *Args*	  :
	#	- +ascii_character+ -> ascii character to convert
	# * *Returns* :
	# 	- Fixnum integer corresponding to ascii digit, if input is digit; otherwise nil
	# * *Raises*  :
	#	- This method contains no additional errors
	def ascii_lookup(ascii_character)
		return @@ascii_hash[ascii_character]
	end
end	