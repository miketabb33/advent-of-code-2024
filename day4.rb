input = File.read("day4_input")

def buildMap(input)
  lines = input.split("\n")

  map = []

  i = 0
  while i < lines.size
    currentLine = lines[i]
    letters = currentLine.split("")
    j = 0
    while j < letters.size
      letter = letters[j]
      map.push({:value => letter, :row => i, :col => j})
      j+=1
    end

    i+=1
  end
  return map
end

def up(item, map)
  map.find { | candidate | candidate[:row] == item[:row] - 1 && candidate[:col] == item[:col] }
end

def upRight(item, map)
  map.find { | candidate | candidate[:row] == item[:row] - 1 && candidate[:col] == item[:col] + 1 }
end

def upLeft(item, map)
  map.find { | candidate | candidate[:row] == item[:row] - 1 && candidate[:col] == item[:col] - 1 }
end

def right(item, map)
  map.find { | candidate | candidate[:row] == item[:row] && candidate[:col] == item[:col] + 1 }
end

def down(item, map)
  map.find { | candidate | candidate[:row] == item[:row] + 1 && candidate[:col] == item[:col] }
end

def downRight(item, map)
  map.find { | candidate | candidate[:row] == item[:row] + 1 && candidate[:col] == item[:col] + 1}
end

def downLeft(item, map)
  map.find { | candidate | candidate[:row] == item[:row] + 1 && candidate[:col] == item[:col] - 1}
end

def left(item, map)
  map.find { | candidate | candidate[:row] == item[:row] && candidate[:col] == item[:col] - 1 }
end

def find(item, map, func, letters)
  if letters.size == 0
    return 1
  end
  result = method(func).call(item, map)
  if result && result[:value] == letters[0]
    find(result, map, func, letters[1...])
  else
    return 0
  end
end

def processX(xItem, map)
  letters = ["M", "A", "S"]
  count = 0
  methods = [:up, :right, :down, :left, :upLeft, :upRight, :downLeft, :downRight]
  methods.each { | method | count += find(xItem, map, method, letters) }
  return count
end

def run(input)
  map = buildMap(input)
  count = 0

  map.each { | item |
    if item[:value] == "X"
      count += processX item, map
    end
  }

  return count
end

test = "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"

result = run(test)

# result = run(input)

puts result





