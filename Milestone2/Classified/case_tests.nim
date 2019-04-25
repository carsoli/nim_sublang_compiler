case readline
of "y", "Y", "yes", "Yes": return true
of "n", "N", "no", "No": return false
else: echo "Please be clear: yes or no"


case name
of "":
    echo "Poor soul, you lost your name?"
of "name":
    echo "Very funny, your name is name."
of "Dave", "Frank":
    echo "Cool name!"
else:
    echo "Hi, ", name, "!"  


case c
of '[':
    inc(b)
of ']':
    dec(b)
    if b < 0: return false
else: discard

case isLeaf: bool
of true:  data: T
of false: list: seq[TreeList[T]]
