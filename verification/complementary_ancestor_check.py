"""Independent actual-map checks for the second-review constructive lemmas."""
import json


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def vp(n, p):
    require(n > 0, "positive valuation input")
    v = 0
    while n % p == 0:
        n //= p
        v += 1
    return v


def T(n):
    return (3 * n + 1) // 2 if n % 2 else n // 2


def forward(n, k):
    for _ in range(k):
        n = T(n)
    return n


def inverse(n, word):
    for c in word:
        if c == "E":
            n *= 2
        else:
            require(n % 3 == 2, "odd inverse guard")
            n = (2 * n - 1) // 3
        require(n > 0, "positive inverse path")
    return n


BASE = {1: (1, "EEEEEE"), 2: (1, "EE"), 5: (2, "EEEE"),
        7: (1, ""), 8: (2, "EEEE")}
TAILS = [(81, 38, "EEO"), (81, 65, "OEEE"),
         (243, 11, "OEEEOE"), (243, 92, "EEOEEOEE"),
         (243, 173, "EEOOE")]


def new_coordinate(r):
    v = vp(128 * r - 157, 3)
    require(v >= 17, "new valuation guard")
    u = (128 * r - 157) // 3**v
    theta = pow(2, v - 5, 9) * u % 9
    if theta == 4:
        h = 1
        x = 2**(v - 5) * 3 * u - 1
        matches = [w for mod, a, w in TAILS if x % mod == a]
        require(len(matches) == 1, "exhaustive unique tail")
        w = matches[0]
    else:
        h, w = BASE[theta]
        x = 2**(v - h - 4) * 3**h * u - 1
    prefix = "OEOOEOE" + "O" * (v - h - 4)
    require(inverse(r, prefix) == x, "prefix formula")
    m = inverse(x, w)
    b = v - h + 3 + len(w)
    require(0 < m < r and m % 27 == 20, "root order and target membership")
    require(forward(m, b) == r, "actual new-coordinate orbit")
    require(vp(r + 7, 3) == 4 and vp(4 * r + 1, 3) == 3,
            "complementarity valuations")
    return {"r": r, "m": m, "steps": b, "v": v, "theta": theta}


def main():
    count_fixed = 0
    for a, period, b, slope, w in [
        (4529, 19683, 3179, 13824, "OEOOEOEOO"),
        (17813, 59049, 16679, 55296, "OEOEEOOEOOO")]:
        for t in list(range(1000)) + [10**20, 10**100]:
            r, m = a + period*t, b + slope*t
            require(inverse(r, w) == m, "fixed cylinder inverse formula")
            require(forward(m, len(w)) == r, "fixed cylinder forward replay")
            require(0 < m < r and m % 27 == r % 27 == 20, "fixed cylinder order")
            require(vp(r+7, 3) == 4 and vp(4*r+1, 3) == 3, "fixed labels")
            count_fixed += 1
        for q in range(70):
            modulus = 2**(q+1)
            t = ((2**q-a-5) * pow(period, -1, modulus)) % modulus
            require(vp(a+period*t+5, 2) == q, "arbitrary exact shadow depth")
    count_new = 0
    for v in list(range(17, 70)) + [127, 256, 1024]:
        for u in range(1, 2001):
            if u % 3 == 0 or (3**v*u+157) % 128:
                continue
            new_coordinate((3**v*u+157)//128)
            count_new += 1
    r = (3**16*803+157)//128
    m = 64*(2**11*3*803-1)
    require((r, m) == (270050915, 315752384) and m > r, "guard-loss witness")
    require(forward(m, 24) == r, "guard-loss orbit remains valid")
    count_return = 0
    for q in range(4, 80):
        for u0 in range(1, 100, 2):
            # Preserve oddness while selecting n=20mod27.
            u = u0 + 2*((25*pow(2**q, -1, 27)-u0)*pow(2, -1, 27) % 27)
            r = 2**q*u-5
            if r <= 0:
                continue
            y = forward(r, 4)
            require(r % 27 == 20 and vp(r+5, 2) == q, "return root guards")
            require(all(forward(r, j) % 27 != 20 for j in [1, 2, 3]), "first return")
            require(y == (27*r+23)//16 and y > r and y % 243 == 20,
                    "growing return and ternary state")
            qy = 0 if q == 4 else (1+vp(27*u-1, 2) if q == 5 else 1)
            require(vp(y+5, 2) == qy, "return shadow transition")
            count_return += 1
    # The remaining cylinder permits every prescribed exact recharge depth.
    # These checks identify missed guards; they make no nonconvergence claim.
    residual_count = 0
    for depth in range(70):
        modulus = 2**(depth+1)
        s = ((2**depth-2386)*pow(19683, -1, modulus)) % modulus
        r = 22619+186624*s
        y = 38171+314928*s
        u = 707+5832*s
        require(forward(r, 4) == y and y > r, "residual growing first return")
        require(r % 729 == 20 and vp(r+5, 2) == 5, "residual source guards")
        require(r+5 == 32*u and u % 8 == 3, "outside q2 exit guard")
        require(vp(4*r+1, 3) == 4 and 4*((4*r+1)//81) % 9 == 4,
                "outside original ancestor selector")
        require(vp(y+5, 2) == 4+depth, "arbitrary exact residual recharge")
        residual_count += 1
    print(json.dumps({"status": "passed", "fixed_cylinder_replays": count_fixed,
                      "new_coordinate_replays": count_new,
                      "first_return_replays": count_return,
                      "residual_recharge_replays": residual_count,
                      "new_example": new_coordinate((3**17*865+157)//128),
                      "scope": "guarded infinite families, no universal closure"}, indent=2))


if __name__ == "__main__":
    main()
