/+  default-agent
|%
+$  card  card:agent:gall
+$  example-data
  $:  date=@da
      name=@t
      counter=@ud
      color=@ux
  ==
+$  example-action
  $%  [%change-date date=@da]
  ==
+$  versioned-state
  $%  state-zero
  ==
+$  state-zero
  $:  %0
      =example-data
  ==
--
=|  state-zero
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this        .
    def         ~(. (default-agent this %|) bowl)
::
++  on-init  on-init:def
++  on-save  !>(state)
++  on-load  |=(old=vase `this(state !<(state-zero old)))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  (team:title our.bowl src.bowl)
  (on-poke:def mark vase)
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
