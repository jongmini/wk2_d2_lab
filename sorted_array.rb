class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el  #places the value in the correct position
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block

    # loop over all elements in @internal_arr
    # yield to each element
    # set the index lo and hi and keep track
    i = 0
    while i < @internal_arr.size # or use until i == arr.size
      yield @internal_arr[i]
      i += 1  
    end
    return @internal_arr
  end

  def map &block # what's the diff btw each vs map?
    # use self.each &block

    temp_array=[]
    self.each{ |element| temp_array << yield(element) }
    
    temp_array
  end

  def map! &block
    temp_array=[]
    i = 0
    while i < @internal_arr.size 
      temp_array << (yield @internal_arr[i])
      i += 1  
    end
    @internal_arr = temp_array
    return @internal_arr

  end

  def find value

    i = 0
    until i > @internal_arr.length
      if yield(@internal_arr[i])
        @internal_arr[i]
        i += 1
      else
        nil
      end
    end

  end

  def inject acc=nil, &block
    i = 0
    while i < @internal_arr.length
      acc = (yield acc,@internal_arr[i])
      i += 1
    end 
    return acc

  end

end
