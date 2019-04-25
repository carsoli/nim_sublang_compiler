block outer:
    for i in 0..2000:
        for j in 0..2000:
            if i+j == 3145:
                echo i, ", ", j
                break outer

block busyloops:
    while true:
        while true:
            break busyloops

    