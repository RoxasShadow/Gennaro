Gennaro - È attento alla strada
=================================================
Gennaro is a skeleton generator for Sinatra, Padrino or what you want.
As built-in skeleton at the moment it has just `authentication`, but you are free to add any template you want.


Install
====
`$ gem install gennaro`


Example
====
Generate the `authentication` skeleton for your app named `App` in the current path

`$ gennaro -g authentication`

--------------
Generate the `authentication` skeleton for your app named `Example` the folder `server`

`$ gennaro -g authentication -c Example -p server`

--------------
Use some other standalone skeleton

`$ gennaro -g mycoolskeleton -c Example -p server -t my_templates`

--------------
Show all the built-in skeletons

`$ gennaro -l`

--------------
Show the help

`$ gennaro -h`
