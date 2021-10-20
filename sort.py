def quicksort(xs):
    if len(xs) == 0:
        return []

    pivot = xs[0]
    xs = xs[1:]
    left = [x for x in xs if x <= pivot]
    right = [x for x in xs if x > pivot]

    res = quicksort(left)
    res.append(pivot)
    res += quicksort(right)
    return res


xs = [1, 3, 2, 4, 5, 2]
sorted_xs = quicksort(xs)
