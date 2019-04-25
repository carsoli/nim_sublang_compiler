macro multiMatch(inp: string; sections: untyped): untyped =
    ## "Multi regex match". Usage:
    ## multiMatch inp:
    ## of pattern1:
    ##   x = matches[0]
    ## of pattern2:
    ##   ...
    template branch(inp, p, action) =
        import xlen