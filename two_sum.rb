#O(n^2)
def bad_two_sum?(arr, target_sum)
    (0...arr.length).each do |i|
        (i+1...arr.length).each do |j|
            return true if arr[i] + arr[j] == target_sum
        end
    end
    false
end


arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10) # => should be false

#O(n log n)
def okay_two_sum?(arr, target_sum)
    arr.sort!
    i = 0
    j = arr.size - 1
    while i < j
        sum = arr[i] + arr[j]
        if sum == target_sum
            return true
        elsif sum < target_sum
            i += 1
        else
            j -= 1
        end
    end
    false
end


#p okay_two_sum?(arr, 6) # => should be true
#p okay_two_sum?(arr, 10) # => should be false
require 'set'
#O(n)
def two_sum?(arr, target_sum)
    set = Set.new

    arr.each do |val|
        #if the hash[target - val] exists, then its true
        needed_val = target_sum - val
        
        if set.include?(needed_val)
            return true 
        else
            set.add(val)
        end
    end
    false
end

arr = [0, 1, 5, 7]

p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false