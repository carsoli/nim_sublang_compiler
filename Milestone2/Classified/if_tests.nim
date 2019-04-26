##input1
if name == "":
    echo "Poor soul, you lost your name?"
elif name == "name":
    echo "Very funny, your name is name."
else:
  echo "Hi, ", name, "!"
##

if x4: x4 = false
##

if not x4:
    if y4:
        y4 = false
    else:
        y4 = true
##

if not x4:
    x4 = true
    y4 = true    
##

if yes("Should I delete all your important files?"):
    echo "I'm sorry Dave, I'm afraid I can't do that."
else:
    echo "I think you know what the problem is just as well as I do."
##

if i+j == 3145:
    echo i, ", ", j
    break outer

##

if n < 2:
    result = n
else:
    result = fibonacci(n - 1) + (n - 2).fibonacci

if i+j == 3145:
    echo i, ", ", j
    break outer

##input2
if n == 0:
    bs = "No more bottles"
elif n == 1:
    bs = "1 bottle"
else:
    bs = $n & " bottles"

##input3

var r = if inr >= 0: inr else: a.high
##

if n < 2: return
##

if a[l] < p:
    inc l
    continue
if a[r] > p:
    dec r
    continue
if l <= r:
    swap a[l], a[r]
    inc l
    dec r

## input 4
var k = if decode: 26 - k else: k
#matches all tokens but is wrong
if ord(i) >= 65 and ord(i) <= 90:
    result.add(chr((ord(i) - 65 + k) mod 26 + 65))


##input 5
if b < 0: return false

if balanced(s): "balanced" else: "not balanced"

## input 6
if n.isLeaf: result = $n.data
else:
    result = "["
    for i, x in n.list:
        if i > 0: result.add ", "
        result.add($x)
    result.add "]"

if n.isLeaf: result = @[n.data]
else:
    result = @[]
    for x in n.list:
        result.add flatten x

##input7
if mmlen > 0:
    action
    inc(mmpos, mmlen)
    break searchSubs


##input 9
if guess < answer:
    echo "Too low, try again"
elif guess > answer:
    echo "Too high, try again"
else:
    echo "Correct!"
    break

        
