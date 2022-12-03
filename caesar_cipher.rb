# Character   Ascii Code
#-----------------------
#    a          97
#    z          122
#    A          65
#    Z          90



def safe_shift (char_code, shift_factor, low_limit, upper_limit)
  rotate = shift_factor > 0 ? 26 : -26
  char_code += shift_factor
  char_code -= rotate unless char_code.between?(low_limit, upper_limit)
  char_code
end

def encode_char (character, shift_factor)
  char_code = character.ord
  (a,z) = case char_code
              when 97..122
                [97,122]#safe_shift(char_code, shift_factor, 97, 122)
              when 65..90
                [65,90]#safe_shift(char_code, shift_factor, 65, 90)
              else
                char_code                
          end
  char_code = safe_shift(char_code, shift_factor, a, z) if !z.nil?
  char_code.chr
end

def caesar_cipher(string, shift_factor)
  enc = ""
  string.each_char{|ch| enc << encode_char(ch, shift_factor)}
  enc
end

