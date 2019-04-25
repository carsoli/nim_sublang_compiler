TTreeList[T] = object
    case isLeaf: bool
    of true:  data: T
    of false: list: seq[TreeList[T]]
