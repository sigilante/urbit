/-  *post
|%
+$  feeds  (map path feed)
::
+$  feed  (list post)
::
+$  feed-action
  $%  ::  %path: initialize a path to an empty map of uid to thread
      ::
      [%create-feed =path]
      [%post =path =post]
      [%delete-feed =path]
      [%oust-time-feed =path start=@ end=@]
  ==
--
