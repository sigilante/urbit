/-  *identity
|%
+$  uid  @uvH
::
+$  post
  $:  =uid
      =identity
      when=time
      =container
      parent=(list uid)     ::  TODO: implement filters for 0/1 item in hook
      children=(list uid)
  ==
::
+$  container
  $%  [%content =content] 
      [%multiple multiple=(list content)]
  ==
::
+$  content
  $%  [%text text=cord]
      [%url url=cord]
      [%udon udon=manx]
      [%blob mime=@t =beam]
      [%uid =uid]
  ==
--
