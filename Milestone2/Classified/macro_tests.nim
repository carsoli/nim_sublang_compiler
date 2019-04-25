macro multiMatch(inp: string; sections: untyped): untyped =
    ## "Multi regex match". Usage:
    ## multiMatch inp:
    ## of pattern1:
    ##   x = matches[0]
    ## of pattern2:
    ##   ...
    template branch(inp, p, action) =
        var mmlen = matchLen(inp, mmpatterns[p], matches, mmpos)
        if mmlen > 0:
            action
            inc(mmpos, mmlen)
            break searchSubs
