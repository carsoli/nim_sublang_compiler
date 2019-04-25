while x3 <= 5:
    echo "Counting : ", x3
    x3 = x3 + 1  

while true:
    case readline
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo "Please be clear: yes or no"

while true:
    echo "looping"
    break

while mmpos < inp.len:
    block searchSubs:
        actions
        inc(mmpos)

while true:
    echo "I have a number from 1 to 10, what is it? "
    let guess = parseInt(stdin.readLine)

    if guess < answer:
        echo "Too low, try again"
    elif guess > answer:
        echo "Too high, try again"
    else:
        echo "Correct!"
        break
        
while l <= r:
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