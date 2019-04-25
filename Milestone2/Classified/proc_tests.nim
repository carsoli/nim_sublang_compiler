proc L[T](list: varargs[TreeList[T]]): TreeList[T] =
    var s: seq[TreeList[T]] = @[]
    for x in list: s.add x
    TreeList[T](isLeaf: false, list: s)

proc N[T](data: T): TreeList[T] =
    TreeList[T](isLeaf: true, data: data)
 
proc `$`[T](n: TreeList[T]): string =
    if n.isLeaf: result = $n.data
    else:
        result = "["
        for i, x in n.list:
            if i > 0: result.add ", "
            result.add($x)
        result.add "]"
 
proc flatten[T](n: TreeList[T]): seq[T] =
    if n.isLeaf: result = @[n.data]
    else:
        result = @[]
        for x in n.list:
            result.add flatten x

proc gen(n: int): string =
    result = "[]".repeat(n)
    shuffle(result)
 
proc balanced(txt: string): bool =
    var b = 0
    for c in txt:
        case c
        of '[':
            inc(b)
        of ']':
            dec(b)
            if b < 0: return false
        else: discard
    b == 0


proc caesar(s: string, k: int, decode = false): string =
    var k = if decode: 26 - k else: k
    result = ""
    for i in toUpper(s):
        if ord(i) >= 65 and ord(i) <= 90:
            result.add(chr((ord(i) - 65 + k) mod 26 + 65))

proc quickSort[T](a: var openarray[T], inl = 0, inr = -1) =
    var r = if inr >= 0: inr else: a.high
    var l = inl
    let n = r - l + 1
    if n < 2: return
    let p = a[l + 3 * n div 4]
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
    quickSort(a, inl, r)
    quickSort(a, l, inr)

proc GetBottleNumber(n: int): string =
    var bs: string
    if n == 0:
        bs = "No more bottles"
    elif n == 1:
        bs = "1 bottle"
    else:
        bs = $n & " bottles"
    return bs & " of beer"

proc fibonacci(n: int): int =
    if n < 2:
        result = n
    else:
        result = fibonacci(n - 1) + (n - 2).fibonacci

proc echoItem(x: string) = echo x

proc forEach(action: proc (x: string)) =
    const
        data = ["hi", "bye", "later", "not today", "leave[]"]
    for d in items(data):
        action(d)

proc yes(question: string): bool =
    echo question, " (y/n)"
    var readline = "n"
    while true:
        case readline
        of "y", "Y", "yes", "Yes": return true
        of "n", "N", "no", "No": return false
        else: echo "Please be clear: yes or no"
