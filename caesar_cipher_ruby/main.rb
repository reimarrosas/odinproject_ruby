# frozen_string_literal: true

# Shifts the char ord with the amount given using modulus and normalization
# 1. Subtracts the char_ord with the normalizer based of the ord >= 'a'.ord
#    so that it is normalized to something between 0-25, representing the
#    letters of the alphabet
# 2. Shifts the amount by the given shift_amount `mod` 26 so it still falls
#    within the 26 letters of the alphabet
# 3. Add back the normalizer so it becomes the correct ascii code
# 4. Convert ascci code to char
#
def shifter(char_ord, shift_amount)
  normalizer = char_ord >= 'a'.ord ? 97 : 65
  ((((char_ord - normalizer) + shift_amount) % 26) + normalizer).chr
end

# Encodes the plain_text string using caesar cipher
# 1. Loop through each char in the string
# 2. Check if char is alphabetic
# 3 if alphabetic, use the shifter function to shift it `shift_amount`
#   letters up
# 4. else, keep the char
def caesar_cipher(plain_text, shift_amount)
  plain_text.split('').map { |char| /[a-zA-Z]/.match(char) ? shifter(char.ord, shift_amount) : char }.join
end

print 'Enter your message: '
message = gets.chomp
print 'Enter the amount to shift [1-25]: '
shift = gets.chomp.to_i

raise 'invalid shift value!' unless shift.between?(1, 25)

puts "Ciphertext: #{caesar_cipher(message, shift)}"
