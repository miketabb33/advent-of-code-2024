data = File.read("day3_data")

expressions =  data.scan(/mul\(\d{1,3}\,\d{1,3}\)|do\(\)|don\'t\(\)/)

pruned = []

on = true
expressions.each { | ex |
  if ex == "do()"
    on = true
  elsif ex == "don't()"
    on = false
  else
    if on
      pruned.push(ex)
    end
  end
}

arr = pruned.map { | ex | ex[3...].tr("()", "").split(",").map {|x| x.to_i} }

num = 0

arr.each { | a |  num += a[0] * a[1]}

puts num