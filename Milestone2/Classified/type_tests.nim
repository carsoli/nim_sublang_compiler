type
    TreeList[T] = ref TTreeList[T]
    TTreeList[T] = object
        case isLeaf: bool
        of true:  data: T
        of false: list: seq[TreeList[T]]

type
    IntArray = array[0..5, int] 
    QuickArray = array[6, int]  
        
