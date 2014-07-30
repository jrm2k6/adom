adom
====

A Haskell code generator for Android.


### How to run? ###
The project is using hsenv (virtual environment).

To run it, just do:

```
source .hsenv/bin/activate
runhaskell FileUtils.hs defs/YourDefFile.def
```

It will generate a ```YourDefFile.java``` using a template defined in the ```androidtemplates``` folder.

### My development environment ###

``` cabal --version ```
``` -> cabal-install version 1.20.0.3 ```
