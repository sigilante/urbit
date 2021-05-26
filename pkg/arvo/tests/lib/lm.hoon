/+  *test, *lm, lv
::
::::
  ::
=/  rtol  .1e-6
|%
::
::  Tests for matrix creation
::
++  test-zeros  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0000
      !>  (zeros:lms 0 0)
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.0000.0000
      !>  (zeros:lms 1 1)
    %+  expect-eq
      !>  (make:lms ~[~[.0]])
      !>  (zeros:lms 1 1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000
      !>  (zeros:lms 3 3)
    %+  expect-eq
      !>  (make:lms ~[~[.0 .0 .0] ~[.0 .0 .0] ~[.0 .0 .0]])
      !>  (zeros:lms 3 3)
    %+  expect-eq
      !>  `@lms`0x2.0000.0005.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000
      !>  (zeros:lms 5 5)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 5 (reap 5 .0)))
      !>  (zeros:lms 5 5)
    %+  expect-eq
      !>  `@lms`0x2.0000.000c.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000
      !>  (zeros:lms 12 16)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 12 (reap 16 .0)))
      !>  (zeros:lms 16)
  ==
++  test-ones  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0000
      !>  (ones:lms 0 0)
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.3f80.0000
      !>  (ones:lms 1 1)
    %+  expect-eq
      !>  (make:lms ~[~[.1]])
      !>  (ones:lms 1 1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (ones:lms 3 3)
    %+  expect-eq
      !>  (make:lms ~[~[.1 .1 .1] ~[.1 .1 .1] ~[.1 .1 .1]])
      !>  (ones:lms 3 3)
    %+  expect-eq
      !>  `@lms`0x2.0000.0005.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (ones:lms 5 5)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 5 (reap 5 .1)))
      !>  (ones:lms 5 5)
    %+  expect-eq
      !>  `@lms`0x2.0000.000c.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (ones:lms 12 16)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 12 (reap 16 .1)))
      !>  (ones:lms 12 16)
  ==
++  test-id  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.3f80.0000
      !>  (id:lms 3)
    %+  expect-eq
      !>  `@lms`0x2.0000.000c.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.3f80.0000
      !>  (id:lms 12)
  ==
++  test-fill  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0000
      !>  (fill:lms 0 0 .0)
    %+  expect-eq
      !>  `@lms`0x2.0000.0000
      !>  (fill:lms 0 0 .1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.0000.0000
      !>  (fill:lms 1 1 .0)
    %+  expect-eq
      !>  (make:lms ~[~[.0]])
      !>  (fill:lms 1 1 .0)
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.3f80.0000
      !>  (fill:lms 1 1 .1)
    %+  expect-eq
      !>  (make:lms ~[~[.1]])
      !>  (fill:lms 1 1 .1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.bf80.0000
      !>  (fill:lms 1 1 .-1)
    %+  expect-eq
      !>  (make:lms ~[~[.-1]])
      !>  (fill:lms 1 1 .-1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (fill:lms 3 3 .1)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 3 (reap 3 .1)))
      !>  (fill:lms 3 3 .1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0005.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (fill:lms 5 5 .1)
    %+  expect-eq
      !>  (make:lms `(list (list @rs))`(reap 5 (reap 5 .1)))
      !>  (fill:lms 5 5 .1)
  ==
++  test-make  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.0000.0000
      !>  (make:lms ~[~[.0]])
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms `(list (list @rs))`(reap 3 (reap 3 .1)))
    %+  expect-eq
      !>  `@lms`0x2.0000.0005.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms `(list (list @rs))`(reap 5 (reap 5 .1)))
    %+  expect-eq
      !>  `@lms`0x2.0000.000c.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms `(list (list @rs))`(reap 12 (reap 16 .1)))
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.3f80.0000
      !>  (make:lms ~[~[.1]])
    %+  expect-eq
      !>  `@lms`0x2.0000.0001.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms ~[~[.1 .1 .1]])
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms `(list (list @rs))`(reap 4 (reap 5 .1)))
    %+  expect-eq
      !>  `@lms`0x2.0000.0002.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (make:lms `(list (list @rs))`(reap 2 (reap 10 .1)))
    %+  expect-eq
      !>  `@lms`0x2.0000.0002.3f80.0000.4000.0000.4040.0000.4080.0000
      !>  (make:lms ~[~[.1 .2] ~[.3 .4]])
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000.4040.0000.4080.0000.c080.0000.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000.4040.0000.c0a0.0000.c080.0000.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000
      !>  (make:lms ~[~[.-3 .-2 .-1 .0 .1 .2 .3 .4] ~[.-4 .-3 .-2 .-1 .0 .1 .2 .3] ~[.-5 .-4 .-3 .-2 .-1 .0 .1 .2]])
  ==
++  test-unmake  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  ~[~[.0]]
      !>  (unmake:lms `@lms`0x2.0000.0001.0000.0000)
    %+  expect-eq
      !>  `(list (list @rs))`(reap 3 (reap 3 .1))
      !>  (unmake:lms `@lms`0x2.0000.0003.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  `(list (list @rs))`(reap 5 (reap 5 .1))
      !>  (unmake:lms `@lms`0x2.0000.0005.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  `(list (list @rs))`(reap 12 (reap 16 .1))
      !>  (unmake:lms `@lms`0x2.0000.000c.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  ~[~[.1]]
      !>  (unmake:lms `@lms`0x2.0000.0001.3f80.0000)
    %+  expect-eq
      !>  ~[~[.1 .1 .1]]
      !>  (unmake:lms `@lms`0x2.0000.0001.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  `(list (list @rs))`(reap 4 (reap 5 .1))
      !>  (unmake:lms `@lms`0x2.0000.0004.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  `(list (list @rs))`(reap 2 (reap 10 .1))
      !>  (unmake:lms `@lms`0x2.0000.0002.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000)
    %+  expect-eq
      !>  ~[~[.1 .2] ~[.3 .4]]
      !>  (unmake:lms `@lms`0x2.0000.0002.3f80.0000.4000.0000.4040.0000.4080.0000)
    %+  expect-eq
      !>  ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]]
      !>  (unmake:lms `@lms`0x2.0000.0003.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000)
    %+  expect-eq
      !>  ~[~[.-3 .-2 .-1 .0 .1 .2 .3 .4] ~[.-4 .-3 .-2 .-1 .0 .1 .2 .3] ~[.-5 .-4 .-3 .-2 .-1 .0 .1 .2]]
      !>  (unmake:lms `@lms`0x2.0000.0003.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000.4040.0000.4080.0000.c080.0000.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000.4040.0000.c0a0.0000.c080.0000.c040.0000.c000.0000.bf80.0000.0000.0000.3f80.0000.4000.0000)
  ==
++  test-make-unmake  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]]
      !>  (unmake:lms (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]]))
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (make:lms (unmake:lms `@lms`0x2.0000.0003.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000))
  ==
::
::  Tests for utility functions
::
++  test-shape  ^-  tang
  ;:  weld
    %+  expect-eq
      !>  `(list @ud)`~[3 3]
      !>  (shape:lms (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]]))
    %+  expect-eq
      !>  `(list @ud)`~[2 3]
      !>  (shape:lms (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6]]))
    %+  expect-eq
      !>  `(list @ud)`~[3 2]
      !>  (shape:lms (make:lms ~[~[.1 .2] ~[.4 .5] ~[.7 .8]]))
  ==
++  test-get  !!
++  test-getc  !!
++  test-getr  !!
::
::  Tests for matrix alteration
::
++  test-set  !!
++  test-setc  !!
++  test-setr  !!
++  test-swapc  !!
++  test-swapr  !!
++  test-trans  !!
::
::  Tests for matrix arithmetic
::
++  test-adds  !!
++  test-subs  !!
++  test-muls  !!
++  test-divs  !!
++  test-addsc
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.2 .2 .3 .4 .5] ~[.6 .6 .7 .8 .9] ~[.1e1 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.1.4e1 .1.4e1 .1.5e1 .1.6e1 .1.7e1]])
      !>  (addsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.4000.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4120.0000.4120.0000.4130.0000.4140.0000.4150.0000.4160.0000.4160.0000.4170.0000.4180.0000.4188.0000
      !>  (addsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .1)
  ==
++  test-subsc
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.0 .2 .3 .4 .5] ~[.4 .6 .7 .8 .9] ~[.8 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.1.2e1 .1.4e1 .1.5e1 .1.6e1 .1.7e1]])
      !>  (subsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.0000.0000.4000.0000.4040.0000.4080.0000.40a0.0000.4080.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4100.0000.4120.0000.4130.0000.4140.0000.4150.0000.4140.0000.4160.0000.4170.0000.4180.0000.4188.0000
      !>  (subsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .1)
  ==
++  test-mulsc
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.2 .2 .3 .4 .5] ~[.1e1 .6 .7 .8 .9] ~[.1.8e1 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.2.6e1 .1.4e1 .1.5e1 .1.6e1 .1.7e1]])
      !>  (mulsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .2)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.4000.0000.4000.0000.4040.0000.4080.0000.40a0.0000.4120.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4190.0000.4120.0000.4130.0000.4140.0000.4150.0000.41d0.0000.4160.0000.4170.0000.4180.0000.4188.0000
      !>  (mulsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .2)
  ==
++  test-divsc
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.5e-1 .2 .3 .4 .5] ~[.2.5 .6 .7 .8 .9] ~[.4.5 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.6.5 .1.4e1 .1.5e1 .1.6e1 .1.7e1]])
      !>  (divsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .2)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f00.0000.4000.0000.4040.0000.4080.0000.40a0.0000.4020.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4090.0000.4120.0000.4130.0000.4140.0000.4150.0000.40d0.0000.4160.0000.4170.0000.4180.0000.4188.0000
      !>  (divsc:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 1 .2)
  ==
++  test-addsr
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.1.8e1 .1.9e1 .2e1 .2.1e1 .2.2e1]])
      !>  (addsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4110.0000.4120.0000.4130.0000.4140.0000.4150.0000.4150.0000.4160.0000.4170.0000.4180.0000.4188.0000
      !>  (addsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
  ==
++  test-subsr
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.8 .9 .1e1 .1.1e1 .1.2e1]])
      !>  (subsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4110.0000.4120.0000.4130.0000.4140.0000.4150.0000.4100.0000.4110.0000.4120.0000.4130.0000.4140.0000
      !>  (subsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
  ==
++  test-mulsr
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.6.5e1 .7e1 .7.5e1 .8e1 .8.5e1]])
      !>  (mulsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4110.0000.4120.0000.4130.0000.4140.0000.4150.0000.4282.0000.428c.0000.4296.0000.42a0.0000.42aa.0000
      !>  (mulsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
  ==
++  test-divsr
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .1e1 .1.1e1 .1.2e1 .1.3e1] ~[.2.6 .2.8 .3 .3.1999998 .3.3999999]])
      !>  (divsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000.4110.0000.4120.0000.4130.0000.4140.0000.4150.0000.4026.6666.4033.3333.4040.0000.404c.cccc.4059.9999
      !>  (divsr:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) 4 .5)
  ==
++  test-addvc
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vc  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.4130.0000.4000.0000.4040.0000.4170.0000.40a0.0000.40c0.0000.4198.0000.4100.0000.4110.0000
      !>  (addvc:lms mr 1 vc)
    ==
++  test-subvc
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vc  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.c110.0000.4000.0000.4040.0000.c0e0.0000.40a0.0000.40c0.0000.c0a0.0000.4100.0000.4110.0000
      !>  (subvc:lms mr 1 vc)
  ==
++  test-mulvc
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vc  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.4120.0000.4000.0000.4040.0000.4230.0000.40a0.0000.40c0.0000.42a8.0000.4100.0000.4110.0000
      !>  (mulvc:lms mr 1 vc)
  ==
++  test-divvc
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vc  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3dcc.cccc.4000.0000.4040.0000.3eba.2e8b.40a0.0000.40c0.0000.3f15.5555.4100.0000.4110.0000
      !>  (divvc:lms mr 1 vc)
  ==
++  test-addvr
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vr  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.4130.0000.4150.0000.4170.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (addvr:lms mr 1 vr)
  ==
++  test-subvr
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vr  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.c110.0000.c110.0000.c110.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (subvr:lms mr 1 vr)
  ==
++  test-mulvr
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vr  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.4120.0000.41b0.0000.4210.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (mulvr:lms mr 1 vr)
  ==
++  test-divvr
  =/  mr  `@lms`(make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  =/  vr  `@lvs`(make:lvs ~[.10 .11 .12])
  ;:  weld
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3dcc.cccc.3e3a.2e8b.3e80.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (divvr:lms mr 1 vr)
  ==
++  test-addm
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.2 .4 .6 .8 .1e1] ~[.1e1 .1.2e1 .1.4e1 .1.6e1 .1.8e1] ~[.1.8e1 .2e1 .2.2e1 .2.4e1 .2.6e1] ~[.2.6e1 .2.8e1 .3e1 .3.2e1 .3.4e1]])
      !>  (addm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.4000.0000.4080.0000.40c0.0000.4100.0000.4120.0000.4120.0000.4140.0000.4160.0000.4180.0000.4190.0000.4190.0000.41a0.0000.41b0.0000.41c0.0000.41d0.0000.41d0.0000.41e0.0000.41f0.0000.4200.0000.4208.0000
      !>  (addm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
  ==
++  test-subm
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.0 .0 .0 .0 .0] ~[.0 .0 .0 .0 .0] ~[.0 .0 .0 .0 .0] ~[.0 .0 .0 .0 .0]])
      !>  (subm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000.0000
      !>  (subm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
  ==
++  test-mulm
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .4 .9 .1.6e1 .2.5e1] ~[.2.5e1 .3.6e1 .4.9e1 .6.4e1 .8.1e1] ~[.8.1e1 .1e2 .1.21e2 .1.44e2 .1.69e2] ~[.1.69e2 .1.96e2 .2.25e2 .2.56e2 .2.89e2]])
      !>  (mulm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.4080.0000.4110.0000.4180.0000.41c8.0000.41c8.0000.4210.0000.4244.0000.4280.0000.42a2.0000.42a2.0000.42c8.0000.42f2.0000.4310.0000.4329.0000.4329.0000.4344.0000.4361.0000.4380.0000.4390.8000
      !>  (mulm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
  ==
++  test-divm
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .1 .1 .1 .1] ~[.1 .1 .1 .1 .1] ~[.1 .1 .1 .1 .1] ~[.1 .1 .1 .1 .1]])
      !>  (divm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
    %+  expect-eq
      !>  `@lms`0x2.0000.0004.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000.3f80.0000
      !>  (divm:lms (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]) (make:lms `(list (list @rs))`~[~[.1 .2 .3 .4 .5] ~[.5 .6 .7 .8 .9] ~[.9 .10 .11 .12 .13] ~[.13 .14 .15 .16 .17]]))
  ==
++  test-mmul
  =/  m  (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6]])
  =/  n  (make:lms ~[~[.7 .8] ~[.9 .10] ~[.11 .12]])
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.5.8e1 .6.4e1] ~[.1.39e2 .1.54e2]])
      !>  (mmul:lms m n)
    %+  expect-eq
      !>  `@lms`0x2.0000.0002.4268.0000.4280.0000.430b.0000.431a.0000
      !>  (mmul:lms m n)
  ==
++  test-mpow
  =/  m  (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
  ;:  weld
    %+  expect-eq
      !>  (make:lms ~[~[.1 .2 .3] ~[.4 .5 .6] ~[.7 .8 .9]])
      !>  (mpow:lms m 1)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.3f80.0000.4000.0000.4040.0000.4080.0000.40a0.0000.40c0.0000.40e0.0000.4100.0000.4110.0000
      !>  (mpow:lms m 1)
    %+  expect-eq
      !>  (make:lms ~[~[.3e1 .3.6e1 .4.2e1] ~[.6.6e1 .8.1e1 .9.6e1] ~[.1.02e2 .1.26e2 .1.5e2]])
      !>  (mpow:lms m 2)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.41f0.0000.4210.0000.4228.0000.4284.0000.42a2.0000.42c0.0000.42cc.0000.42fc.0000.4316.0000
      !>  (mpow:lms m 2)
    %+  expect-eq
      !>  (make:lms ~[~[.4.68e2 .5.76e2 .6.84e2] ~[.1.062e3 .1.305e3 .1.548e3] ~[.1.656e3 .2.034e3 .2.412e3]])
      !>  (mpow:lms m 3)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.43ea.0000.4410.0000.442b.0000.4484.c000.44a3.2000.44c1.8000.44cf.0000.44fe.4000.4516.c000
      !>  (mpow:lms m 3)
    %+  expect-eq
      !>  (make:lms ~[~[.7.56e3 .9.288e3 .1.1016e4] ~[.1.7118e4 .2.1033e4 .2.4948e4] ~[.2.6676e4 .3.2778e4 .3.888e4]])
      !>  (mpow:lms m 4)
    %+  expect-eq
      !>  `@lms`0x2.0000.0003.45ec.4000.4611.2000.462c.2000.4685.bc00.46a4.5200.46c2.e800.46d0.6800.4700.0a00.4717.e000
      !>  (mpow:lms m 4)
  ==

++  test-trace  !!
++  test-submatrix  !!
++  test-augment  !!
++  test-minor  !!

++  test-invert  !!
--
