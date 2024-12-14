data = File.read("day2_data")

def assert(expected, actual)
  if expected != actual
    raise "#{expected} does not equal #{actual}"
  end
end

def getDiff(numbers)
  i = 0
  diff = []
  until i > (numbers.size - 2)
    currentNum = numbers[i].to_i
    nextNum = numbers[i + 1].to_i
    diff << nextNum - currentNum
    i += 1
  end
  return diff
end

assert([1,1,1], getDiff([1, 2, 3, 4]))
assert([2,-4,7], getDiff([1, 3, -1, 6]))
assert([-1,-1,-1], getDiff([4, 3, 2, 1]))
assert([-2, -1, -4, -1], getDiff([9, 7, 6, 2, 1]))

def sameDirection(diff)
  dir = []
  i = 0
  while i < diff.size
    if diff[i] > 0
      dir << :asc
    elsif diff[i] < 0
      dir << :desc
    else
      dir << :none
    end
    i+=1
  end
  if (dir.include? :none)
    return false
  end
  return dir.uniq.size == 1
end

assert(true, sameDirection([1, 1, 1]))
assert(true, sameDirection([-1, -2, -1]))
assert(false, sameDirection([1, 0, 1]))
assert(false, sameDirection([1, -1, 1]))
assert(false, sameDirection([0, 0, 0]))
assert(true, sameDirection([-2, -1, -4, -1]))

def safeDistance(diff)
  diff.all? { | d | d.abs < 4 }
end

assert(true, safeDistance([1,1,1]))
assert(true, safeDistance([1,3,1]))
assert(false, safeDistance([1,7,1]))
assert(false, safeDistance([-2, -1, -4, -1]))


def isSafe?(numbers)
  diff = getDiff(numbers)

  return sameDirection(diff) && safeDistance(diff)
end

def processLine(line)
  isOneSafe = false
  numbers = line.split

  i = 0
  while i < numbers.size
    num = copy_wo_element(numbers, i)
    if isSafe?(num)
      return true
    end
    i+=1
  end

  return false
end

def copy_wo_element(arr, index_to_exclude)
  arr[0,index_to_exclude].concat(arr[index_to_exclude+1..-1])
end

def run(data)
  lines = data.split("\n")
  safeLevels = lines.filter { | line |
    processLine(line)
  }
  return safeLevels.size
end

testData = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

assert(4, run(testData))
assert(0, run("9 7 6 2 1"))

puts run(data)