# frozen_string_literal: true

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(word, dictionary)
  normalize_word = word.gsub(/([^a-zA-Z])/, '').downcase
  dictionary.each_with_object({}) do |cur, acc|
    count = normalize_word.scan(cur).count
    acc[cur] = count unless count.zero?
    acc
  end
end

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
