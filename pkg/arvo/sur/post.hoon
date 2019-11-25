/-  *identity
|%
+$  uid  @uvH
::
+$  post
  $:  =uid
      =identity
      when=time
      =container
      parent=(unit uid)
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
