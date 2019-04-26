proc quickSort[T](a: var openarray[T], inl = 0, inr = -1) =
    let n = r - l + 1
    if n < 2: return
    let p = a[l + 3 * n div 4]
    if a[l] < p:
        inc(l)
        continue
    if a[r] > p:
        dec(r)
        continue
    if l <= r:
        swap(a[l], a[r])
        inc(l)
        dec(r)
    quickSort(a, inl, r)
    quickSort(a, l, inr)

proc GetBottleNumber(n: int): string =
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

proc echoItem(x: string) = import x

proc forEach(action: proc (x: string)) =
    for d in items(data):
        action(d)

proc yes(question: string): bool =
    echo(question, " (y/n)")
    case readline
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo("Please be clear: yes or no")