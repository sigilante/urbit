/+  *test, *lv
::
::::
  ::
=/  rtol  .1e-6
|%
::  Auxiliary tools
::    Replace element of c at index a with item b
++  nick
  |*  [a=@ b=* c=(list @)]
  (weld (scag a c) [b (slag +(a) c)])
::    Absolute value
++  absolute
  |=  x=@rs  ^-  @rs
  ?:  (gth:rs x .0)  x
  (sub:rs .0 x)
::    Closeness of two vectors
++  all-close  ^+  %.y
|=  [u=@lvs v=@lvs]  ^-  @rd
  =/  n  `@ud`(length u)
  =/  count  0
  =/  off  0
  |-  ^-  @rd
    ?:  =(count n)  =(0 off)
  $(count +(count), sum (add off `@`(isclose:lvs (get u +(count)) (get v +(count)))))
::
::  Tests for vector creation
::
++  test-zeros  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (zeros:lvs 0)
      !>  `@lvs`0x0
    %+  expect-eq
      !>  (zeros:lvs 1)
      !>  `@lvs`0x100000000
    %+  expect-eq
      !>  (zeros:lvs 1)
      !>  (make:lvs ~[.0])
    %+  expect-eq
      !>  (zeros:lvs 3)
      !>  `@lvs`0x3000000000000000000000000
    %+  expect-eq
      !>  (zeros:lvs 3)
      !>  (make:lvs ~[.0 .0 .0])
    %+  expect-eq
      !>  (zeros:lvs 5)
      !>  `@lvs`0x50000000000000000000000000000000000000000
    %+  expect-eq
      !>  (zeros:lvs 5)
      !>  (make:lvs `(list @rs)`(reap 5 .0))
    %+  expect-eq
      !>  (zeros:lvs 16)
      !>  `@lvs`0x1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    %+  expect-eq
      !>  (zeros:lvs 16)
      !>  (make:lvs `(list @rs)`(reap 16 .0))
  ==
++  test-ones  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (ones:lvs 0)
      !>  `@lvs`0x0
    %+  expect-eq
      !>  (ones:lvs 1)
      !>  `@lvs`0x13ff00000
    %+  expect-eq
      !>  (ones:lvs 1)
      !>  (make:lvs ~[.1])
    %+  expect-eq
      !>  (ones:lvs 3)
      !>  `@lvs`0x33ff000003ff000003ff00000
    %+  expect-eq
      !>  (ones:lvs 3)
      !>  (make:lvs ~[.1 .1 .1])
    %+  expect-eq
      !>  (ones:lvs 5)
      !>  `@lvs`0x53ff000003ff000003ff000003ff000003ff00000
    %+  expect-eq
      !>  (ones:lvs 5)
      !>  (make:lvs `(list @rs)`(reap 5 .1))
    %+  expect-eq
      !>  (ones:lvs 16)
      !>  `@lvs`0x103ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff00000
    %+  expect-eq
      !>  (ones:lvs 16)
      !>  (make:lvs `(list @rs)`(reap 16 .1))
  ==
++  test-fill  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (fill:lvs 0 .0)
      !>  `@lvs`0x0
    %+  expect-eq
      !>  (fill:lvs 0 .1)
      !>  `@lvs`0x0
    %+  expect-eq
      !>  (fill:lvs 1 .0)
      !>  `@lvs`0x100000000
    %+  expect-eq
      !>  (fill:lvs 1 .0)
      !>  (make:lvs ~[.0])
    %+  expect-eq
      !>  (fill:lvs 1 .1)
      !>  `@lvs`0x13ff00000
    %+  expect-eq
      !>  (fill:lvs 1 .1)
      !>  (make:lvs ~[.1])
    %+  expect-eq
      !>  (fill:lvs 1 .-1)
      !>  `@lvs`0x1bf800000
    %+  expect-eq
      !>  (fill:lvs 1 .-1)
      !>  (make:lvs ~[.-1])
    %+  expect-eq
      !>  (fill:lvs 3 .1)
      !>  `@lvs`0x33ff000003ff000003ff00000
    %+  expect-eq
      !>  (fill:lvs 3 .1)
      !>  (make:lvs ~[.1 .1 .1])
    %+  expect-eq
      !>  (fill:lvs 5 .1)
      !>  `@lvs`0x53ff000003ff000003ff000003ff000003ff00000
    %+  expect-eq
      !>  (fill:lvs 5 .1)
      !>  (make:lvs `(list @rs)`(reap 5 .1))
  ==
++  test-make  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lvs`0x0
      !>  (make:lvs 0 .0)  :: XX should fail? check how to test crash
    %+  expect-eq
      !>  `@lvs`0x100000000
      !>  (make:lvs ~[.0])
    %+  expect-eq
      !>  `@lvs`0x3000000000000000000000000
      !>  (make:lvs ~[.0 .0 .0])
    %+  expect-eq
      !>  `@lvs`0x50000000000000000000000000000000000000000
      !>  (make:lvs `(list @rs)`(reap 5 .0))
    %+  expect-eq
      !>  `@lvs`0x1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
      !>  (make:lvs `(list @rs)`(reap 16 .0))
    %+  expect-eq
      !>  `@lvs`0x13ff00000
      !>  (make:lvs ~[.1])
    %+  expect-eq
      !>  `@lvs`0x33ff000003ff000003ff00000
      !>  (make:lvs ~[.1 .1 .1])
    %+  expect-eq
      !>  `@lvs`0x53ff000003ff000003ff000003ff000003ff00000
      !>  (make:lvs `(list @rs)`(reap 5 .1))
    %+  expect-eq
      !>  `@lvs`0x103ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff00000
      !>  (make:lvs `(list @rs)`(reap 16 .0))
    %+  expect-eq
      !>  `@lvs`0x2400000003f800000
      !>  (make:lvs ~[.1 .2])
    %+  expect-eq
      !>  `@lvs`0x340400000400000003f800000
      !>  (make:lvs ~[.1 .2 .3])
    %+  expect-eq
      !>  `@lvs`0x84080000040400000400000003f80000000000000bf800000c0000000c0400000
      !>  (make:lvs ~[.-3 .-2 .-1 .0 .1 .2 .3 .4])
  ==
++  test-unmake  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `(list @rs)`~[.0]
      !>  (unmake:lvs `@lvs`0x100000000)
    %+  expect-eq
      !>  `(list @rs)`~[.0 .0 .0]
      !>  (unmake:lvs `@lvs`0x3000000000000000000000000)
    %+  expect-eq
      !>  `(list @rs)`(reap 5 .0)
      !>  (unmake:lvs `@lvs`0x50000000000000000000000000000000000000000)
    %+  expect-eq
      !>  `(list @rs)`(reap 16 .0)
      !>  (unmake:lvs `@lvs`0x1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
    %+  expect-eq
      !>  `(list @rs)`~[.1]
      !>  (unmake:lvs `@lvs`0x13ff00000)
    %+  expect-eq
      !>  `(list @rs)`~[.1 .1 .1]
      !>  (unmake:lvs `@lvs`0x33ff000003ff000003ff00000)
    %+  expect-eq
      !>  `(list @rs)`(reap 5 .1)
      !>  (unmake:lvs `@lvs`0x53ff000003ff000003ff000003ff000003ff00000)
    %+  expect-eq
      !>  `(list @rs)`(reap 16 .0)
      !>  (unmake:lvs `@lvs`0x103ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff000003ff00000)
    %+  expect-eq
      !>  `(list @rs)`~[.1 .2]
      !>  (unmake:lvs `@lvs`0x2400000003f800000)
    %+  expect-eq
      !>  `(list @rs)`~[.1 .2 .3]
      !>  (unmake:lvs `@lvs`0x340400000400000003f800000)
    %+  expect-eq
      !>  `(list @rs)`~[.-3 .-2 .-1 .0 .1 .2 .3 .4]
      !>  (unmake:lvs `@lvs`0x84080000040400000400000003f80000000000000bf800000c0000000c0400000)
  ==
++  test-make-unmake  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `(list @rs)`~[.1 .2 .3 .4 .5]
      !>  (unmake:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]))
    %+  expect-eq
      !>  0x540a000004080000040400000400000003f800000
      !>  (make:lvs (unmake:lvs 0x540a000004080000040400000400000003f800000))
  ==
::
::  Tests for utility functions
::
++  test-length  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  0
      !>  (length:lvs 0x0)
    %+  expect-eq
      !>  1
      !>  (length:lvs 0x13ff0000)
    %+  expect-eq
      !>  5
      !>  (length:lvs 0x540a000004080000040400000400000003f800000)
  ==
++  test-make-nat  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  0x540a000004080000040400000400000003f800000
      !>  (make-nat:lvs (gulf 1 5))
  ==
++  test-iota  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  0x540a000004080000040400000400000003f800000
      !>  (iota:lvs 5)
  ==
++  test-isclose  ^-  tang
  ;:  weld
    %+  expect
      !>  (isclose:lvs .1  .1.00001)
    %+  expect
      !>  !(isclose:lvs .1 .1.001)
    ::  XX should probably test some pathological cases too
    %+  expect-eq
      !>  (isclose:lvs .1e-6 .0)
      !>  (near0:lvs .1e-6)
  ==
++  test-get  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  .1
      !>  (get:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4]) 1)
    %+  expect-eq
      !>  .2
      !>  (get:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4]) 2)
    %+  expect-eq
      !>  .3
      !>  (get:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4]) 3)
    %+  expect-eq
      !>  .4
      !>  (get:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4]) 4)
    $+  expect-fail
      (get:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4]) 0)
  ==
++  test-max  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  .5
      !>  (max:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]))
    %+  expect-eq
      !>  .5
      !>  (max:lvs (make:lvs `(list @rs)`~[.1 .2 .5 .4 .3]))
    %+  expect-eq
      !>  .5
      !>  (max-rs:lvs .1 .5)
    %+  expect-eq
      !>  .-1
      !>  (max-rs:lvs .-1 .-5)
    %+  expect-eq
      !>  5
      !>  (argmax:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]))
    %+  expect-eq
      !>  3
      !>  (argmax:lvs (make:lvs `(list @rs)`~[.1 .2 .5 .4 .3]))
  ==
::
::  Tests for vector alteration
::
++  test-append  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .3 .4 .5 .6])
      !>  (append:lvs (make:lvs `(list @rs)`~[.2 .3 .4 .5]) .6)
  ==
++  test-set  ^-  tang
  ;:  weld
  %+  expect-eq
    !>  (make:lvs `(list @rs)`~[.5 .2 .3 .4 .5])
    !>  (set:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) 1 .5)
  %+  expect-eq
    !>  (make:lvs `(list @rs)`~[.1 .2 .5 .4 .5])
    !>  (set:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) 3 .5)
  %+  expect-eq
    !>  (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5])
    !>  (set:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) 5 .5)
    ::  TODO XX test out-of-bounds
  ==
++  test-catenate  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .3 .4 .5 .6 .7 .8 .9])
      !>  (catenate:lvs (make:lvs `(list @rs)`~[.2 .3 .4 .5]) (make:lvs `(list @rs)`~[.6 .7 .8 .9]))
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .3 .4 .5 .6 .7 .8 .9])
      !>  (catenate:lvs (make:lvs `(list @rs)`~[.2 .3 .4 .5]) (make:lvs `(list @rs)`~[.6 .7 .8 .9]))
  ==
::
::  Tests for vector arithmetic
::
++  test-adds  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .3 .4 .5 .6])
      !>  (adds:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .1)
      :: argh, we really XX need an expect-close in lib/test
      :: XX or switch to expect isclose instead
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.11 .12 .13 .14 .15])
      !>  (adds:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .10)
  ==
++  test-subs  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.0 .1 .2 .3 .4])
      !>  (subs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .1)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-9 .-8 .-7 .-6 .-5])
      !>  (subs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .10)
  ==
++  test-muls  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5])
      !>  (muls:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .1)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .4 .6 .8 .10])
      !>  (muls:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .2)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-1 .-2 .-3 .-4 .-5])
      !>  (muls:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .-1)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.0.1 .0.2 .0.3 .0.4 .0.5])
      !>  (muls:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .10)
  ==
++  test-divs  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5])
      !>  (divs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .1)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .4 .6 .8 .10])
      !>  (divs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .0.5)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-1 .-2 .-3 .-4 .-5])
      !>  (divs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .-1)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.0.1 .0.2 .0.3 .0.4 .0.5])
      !>  (divs:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]) .0.1)
  ==
++  test-addv  ^-  tang
  =/  vec00000  (zeros:lvs 5)
  =/  vec11111  (ones:lvs 5)
  =/  vec12345  (iota:lvs 5)
  =/  vec54321  (make:lvs `(list @rs)`~[.5 .4 .3 .2 .1])
  =/  vec21012  (make:lvs `(list @rs)`~[.-2 .-1 .0 .1 .2])
  ;:  weld
    %+  expect-eq
      !>  (iota:lvs 5)
      !>  (addv:lvs vec00000 vec12345)
    %+  expect-eq
      !>  (fill:lvs 5 .2)
      !>  (addv:lvs vec11111 vec11111)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.6 .5 .4 .3 .2])
      !>  (addv:lvs vec11111 vec54321)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-1 .0 .1 .2 .3])
      !>  (addv:lvs vec12345 vec21012)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.2 .3 .4 .5 .6])
      !>  (addv:lvs vec11111 vec12345)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-4 .-2 .0 .2 .4])
      !>  (addv:lvs vec21012 vec21012)
  ::  TODO XX test expected failures like diff sizes
  ==
++  test-subv  ^-  tang
  =/  vec00000  (zeros:lvs 5)
  =/  vec11111  (ones:lvs 5)
  =/  vec12345  (iota:lvs 5)
  =/  vec54321  (make:lvs `(list @rs)`~[.5 .4 .3 .2 .1])
  =/  vec21012  (make:lvs `(list @rs)`~[.-2 .-1 .0 .1 .2])
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-1 .-2 .-3 .-4 .-5])
      !>  (subv:lvs vec00000 vec12345)
    %+  expect-eq
      !>  (zeros:lvs 5)
      !>  (subv:lvs vec11111 vec11111)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.4 .3 .2 .1 .0])
      !>  (subv:lvs vec54321 vec11111)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.-1 .0 .1 .0 .-1])
      !>  (subv:lvs vec11111 vec21012)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.0 .-1 .-2 .-3 .-4])
      !>  (subv:lvs vec11111 vec12345)
    %+  expect-eq
      !>  (zeros:lvs 5)
      !>  (subv:lvs vec21012 vec21012)
  ::  TODO XX test expected failures like diff sizes
  ==
++  test-mulv  ^-  tang
  =/  vec00000  (zeros:lvs 5)
  =/  vec11111  (ones:lvs 5)
  =/  vec12345  (iota:lvs 5)
  =/  vec54321  (make:lvs `(list @rs)`~[.5 .4 .3 .2 .1])
  =/  vec21012  (make:lvs `(list @rs)`~[.-2 .-1 .0 .1 .2])
  ;:  weld
    %+  expect-eq
      !>  (zeros:lvs 5)
      !>  (mulv:lvs vec00000 vec12345)
    %+  expect-eq
      !>  (ones:lvs 5)
      !>  (mulv:lvs vec11111 vec11111)
    %+  expect-eq
      !>  vec54321
      !>  (mulv:lvs vec11111 vec54321)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.1 .4 .9 .16 .25])
      !>  (mulv:lvs vec12345 vec12345)
    %+  expect-eq
      !>  vec21012
      !>  (mulv:lvs vec11111 vec21012)
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.4 .2 .0 .2 .4])
      !>  (mulv:lvs vec21012 vec21012)
  ::  TODO XX test expected failures like diff sizes
  ==
++  test-divv  ^-  tang
  =/  vec00000  (zeros:lvs 5)
  =/  vec11111  (ones:lvs 5)
  =/  vec12345  (iota:lvs 5)
  =/  vec54321  (make:lvs `(list @rs)`~[.5 .4 .3 .2 .1])
  =/  vec21012  (make:lvs `(list @rs)`~[.-2 .-1 .0 .1 .2])
  ;:  weld
    %+  expect-eq
      !>  (make:lvs `(list @rs)`~[.1 .0.5 (div:rs .1 .3) .0.25 .0.2])
      !>  (divv:lvs vec11111 vec12345)
    %+  expect-eq
      !>  (ones:lvs 5)
      !>  (divv:lvs vec11111 vec11111)
  ::  TODO XX test expected failures like diff sizes and div-by-zero
  ==
++  test-sum  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  .15
      !>  (sum:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]))
  ==
++  test-product  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  .120
      !>  (product:lvs (make:lvs `(list @rs)`~[.1 .2 .3 .4 .5]))
  ==
++  test-inner  ^-  tang
  =/  vec00000  (zeros:lvs 5)
  =/  vec11111  (ones:lvs 5)
  =/  vec12345  (iota:lvs 5)
  =/  vec54321  (make:lvs `(list @rs)`~[.5 .4 .3 .2 .1])
  =/  vec21012  (make:lvs `(list @rs)`~[.-2 .-1 .0 .1 .2])
  ;:  weld
    %+  expect-eq
      !>  .0
      !>  (inner:lvs vec00000 vec11111)
    %+  expect-eq
      !>  .5
      !>  (inner:lvs vec11111 vec11111)
    %+  expect-eq
      !>  .15
      !>  (inner:lvs vec11111 vec12345)
    %+  expect-eq
      !>  .35
      !>  (inner:lvs vec54321 vec12345)
    %+  expect-eq
      !>  .0
      !>  (inner:lvs vec11111 vec21012)
    %+  expect-eq
      !>  .-10
      !>  (inner:lvs vec54321 vec21012)
    %+  expect-eq
      !>  .10
      !>  (inner:lvs vec21012 vec21012)
  ==
--
