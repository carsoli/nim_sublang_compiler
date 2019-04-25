template branch(inp, p, action) =
    var mmlen = matchLen(inp, mmpatterns[p], matches, mmpos)
    if mmlen > 0:
        action
        inc(mmpos, mmlen)
        break searchSubs

template searchLoop(inp, actions) {.dirty} =
    var mmpos = 0
    while mmpos < inp.len:
        block searchSubs:
            actions
            inc(mmpos)
