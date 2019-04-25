#1
for i in 0..2000:
    for j in 0..2000:
        if i+j == 3145:
            echo i, ", ", j
            break outer

for i in 0..5:
    echo x6[i], y6[i]
    
for value in @[3, 4, 5]:
    echo value

for i, value in @[3, 4, 5]:
    echo "index: ", $i, ", value:", $value    
            
for d in items(data):
    action(d)


#2
for bn in countdown(99, 1):
    var cur = GetBottleNumber(bn)
    echo(cur, " on the wall, ", cur, ".")
    echo("Take one down and pass it around, ", GetBottleNumber(bn-1), " on the wall.\n")


#4
for i in toUpper(s):
    if ord(i) >= 65 and ord(i) <= 90:
        result.add(chr((ord(i) - 65 + k) mod 26 + 65))


#5
for c in txt:
    case c
    of '[':
        inc(b)
    of ']':
        dec(b)
        if b < 0: return false
    else: discard

for n in 0..9:
    let s = gen(n)
    echo "'", s, "' is ", (if balanced(s): "balanced" else: "not balanced")

#6
for x in list: s.add x

for i, x in n.list:
    if i > 0: result.add ", "
    result.add($x)

for x in n.list:
    result.add flatten x


#8
for line in stdin.lines:
    for word in line.split(", "):
        wordFrequencies.inc(word)
