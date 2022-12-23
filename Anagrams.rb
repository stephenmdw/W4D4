#O(n!)
def first_anagram(str1, str2)
    permutations = str1.split("").permutation
    permutations.include?(str2.split(""))
end

#p first_anagram("gizmo", "sally")    #=> false
#p first_anagram("elvis", "lives")    #=> true
#O(n^2)
def second_anagram(str1, str2)
    split1 = str1.split("")
    split2 = str2.split("")
    split1.each do |char|
        idx = split2.find_index(char)
        split2.delete_at(idx) if idx
    end
    split2.empty?
end

# p second_anagram("gizmo", "sally")    #=> false
# p second_anagram("elvis", "lives")    #=> true
#O(nlogn)
def quicksort(str)
    return str if str.size < 2
    pivot = str[0]
    left = str[1..-1].select { |char| char.ord < pivot.ord }
    right = str[1..-1].select { |char| char.ord >= pivot.ord }
    quicksort(left) + [pivot] + quicksort(right)
end

#str = "dbcag".split("")
#p quicksort(str)

def third_anagram?(str1, str2)
    quicksort(str1.split("")) == quicksort(str2.split(""))
end

#p third_anagram?("gizmo", "sally")    #=> false
#p third_anagram?("elvis", "lives")    #=> true

#O(n)
def fourth_anagram?(str1, str2)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)

    str1.each_char { |char| hash1[char] += 1 }
    str2.each_char { |char| hash2[char] += 1 }
    hash1 == hash2
end

p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true