proc L[T](list: varargs[TreeList[T]]): TreeList[T] =
    for x in list: s.add x
    TreeList[T](isLeaf: false, list: s)
