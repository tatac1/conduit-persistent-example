conduit-persistent-example
===

This code demonstrates how to use Conduit together with Persistent to stream data in constant memory in Haskell. Have a look at the accompanying weblog post [here](http://www.jakubkonka.com/2014/01/23/conduit-haskell.html).

# Usage

Make sure you have the following packages installed in your Haskell distribution:

+   Boolean-0.2.3
+   MemoTrie-0.6.2
+   NumInstances-1.4
+   aeson-0.8.0.2
+   attoparsec-0.12.1.2
+   auto-update-0.1.2.1
+   base64-bytestring-1.0.0.1
+   blaze-builder-0.3.3.4
+   blaze-html-0.7.1.0
+   blaze-markup-0.6.3.0
+   blaze-textual-0.2.0.9
+   byteable-0.1.1
+   case-insensitive-1.2.0.3
+   conduit-1.2.3.1
+   conduit-extra-1.1.6.2
+   configurator-0.3.0.0
+   cryptohash-0.11.6
+   dlist-0.7.1
+   exceptions-0.6.1
+   fast-logger-2.2.3
+   hashable-1.2.3.1
+   lifted-base-0.2.3.3
+   logging-2.1.0
+   mmorph-1.0.4
+   monad-control-0.3.3.0
+   monad-control-1.0.0.2
+   monad-logger-0.3.11.1
+   monad-loops-0.4.2.1
+   mtl-2.2.1
+   nats-1
+   network-2.6.0.2
+   network-info-0.2.0.5
+   path-pieces-0.1.5
+   pcre-light-0.4.0.3
+   persistent-2.1.1.4
+   persistent-postgresql-2.1.2.2
+   persistent-template-2.1.0.1
+   postgresql-libpq-0.9.0.2
+   postgresql-simple-0.4.9.0
+   primitive-0.5.4.0
+   random-1.1
+   resource-pool-0.2.3.2
+   resourcet-1.1.3.3
+   scientific-0.3.3.7
+   semigroups-0.16.1
+   silently-1.2.4.1
+   stm-2.4.4
+   stm-chans-3.0.0.2
+   streaming-commons-0.1.9.1
+   suspend-0.2.0.0
+   syb-0.4.4
+   tagged-0.7.3
+   text-1.2.0.4
+   timers-0.2.0.2
+   transformers-0.4.2.0
+   transformers-base-0.4.3
+   unix-compat-0.4.1.4
+   unordered-containers-0.2.5.1
+   uuid-1.3.8
+   vector-0.10.12.2
+   vector-space-0.9
+   void-0.7
+   zlib-0.5.4.2

From the command line, run:

```console
$ cabal sandbox init
$ cabal sandbox --dependencies-only -j
$ cabal configure ; cabal build
```

To compare the memory usage between `selectList` and `selectSource` programs, run:

```console
$ ./dist/build/selectList/selectList +RTS -s
$ ./dist/build/selectSource/selectSource +RTS -s
```

Finally, when you are done, and want to clean up, run:

```console
$ cabal clean clean
```

# License

License information can be found in [LICENSE](LICENSE).
