# Package

version       = "0.1.0"
author        = "metagn"
description   = "test package for lispnimgen"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim", "lispnim"]


# Dependencies

requires "nim >= 1.6.12"
requires "https://github.com/metagn/lispnimgen"

import os, strutils

after install:
  let lispnimgenPath = strip staticExec"nimble path lispnimgen"
  let exePath = lispnimgenPath / "lispnimgen"
  exec quoteShellCommand([exePath, getPkgDir()])

when (compiles do: import nimbleutils):
  import nimbleutils

task tests, "run tests for multiple backends":
  when declared(runTests):
    runTests(backends = {c, js, nims})
  else:
    echo "tests task not implemented, need nimbleutils"
