require 'byebug'
#O(n^2)
def windowed_max_range(array, window_size)
    current_max_range = nil
    (0..array.length-window_size).each do |i|
        max = array[i...i+window_size].max
        min = array[i...i+window_size].min
        diff = max - min
        if current_max_range == nil || current_max_range < diff
            current_max_range = diff
        end
    end
    # p current_max_range
    current_max_range
end

#[0...2] = [0, 1]
#p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
#p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
#p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
#p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

class MyQueue
    def initialize
        @store = []
    end

    def peek
        @store.last
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def enqueue(ele)
        @store.unshift(ele)
        ele
    end

    def dequeue
        @store.pop
    end
end


class MyStack
    def initialize
        @store = []
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def pop
        @store.pop
    end

    def push(ele)
        @store.push(ele)
    end
end

class StackQueue
    def initialize
        @push_stack = Stack.new
        @pop_stack = Stack.new
    end

    def size
        @push_stack.length + @pop_stack.length
    end

    def empty?
        @push_stack.empty? && @pop_stack.empty?
    end

    def enqueue(ele)
        @push_stack.push(ele)
    end

    def dequeue
        if @pop_stack.empty?
            @push_stack.length.times do #is this O(n)?
                pop_val = @push_stack.pop
                @pop_stack.push(pop_val)
            end
        end
        @pop_stack.pop
    end
end

class MinMaxStack
    def initialize
        @store = []
        @minArr = []
        @maxArr = []
    end

    def peek
        @store.first
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def max
        @maxArr.last
    end

    def min
        @minArr.last
    end

    def pop
        pop_val = @store.pop
        @maxArr.pop if pop_val == self.max
        @minArr.pop if pop_val == self.min
    end

    def push(ele)
        @store.push(ele)
        @maxArr << ele if @maxArr.empty? || ele >= @maxArr.last
        @minArr << ele if @minArr.empty? || ele <= @minArr.last
        ele
    end
end

class MinMaxStackQueue

    def initialize
        @push_stack = MinMaxStack.new
        @pop_stack = MinMaxStack.new
    end

    def size
        @push_stack.length + @pop_stack.length
    end

    def empty?
        @push_stack.empty? && @pop_stack.empty?
    end

    def enqueue(ele)
        @push_stack.push(ele)
    end

    def min
        if @push_stack.empty?
            return @pop_stack.min
        elsif @pop_stack.empty?
            return @push_stack.min
        end
        if @push_stack.min < @pop_stack.min then @push_stack.min else @pop_stack.min end
    end

    def max
        if @push_stack.empty?
            return @pop_stack.max
        elsif @pop_stack.empty?
            return @push_stack.max
        end
        if @push_stack.max < @pop_stack.max then @push_stack.max else @pop_stack.max end
    end

    def dequeue
        if @pop_stack.empty?
            @push_stack.size.times do
                pop_val = @push_stack.pop
                p pop_val
                @pop_stack.push(pop_val)
            end
        end
        @pop_stack.pop
    end

end

def stackqueue_windowed_max_range(array, window_size)
    stackQueue = MinMaxStackQueue.new
    window_size.times { stackQueue.enqueue(array.shift) }
    current_max_range = stackQueue.max
    
    array.each do |elem|
        # debugger
        stackQueue.dequeue
        stackQueue.enqueue(elem)
        range = stackQueue.max - stackQueue.min
        current_max_range = range if range > current_max_range
    end
    current_max_range
end

p stackqueue_windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p stackqueue_windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p stackqueue_windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p stackqueue_windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8