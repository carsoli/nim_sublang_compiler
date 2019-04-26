proc quickSort[T](a: var openarray[T], inl = 0, inr = -1) =
    var r = if inr >= 0: inr else: a.high