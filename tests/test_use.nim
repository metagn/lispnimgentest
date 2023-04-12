when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import pkg/lispnimgentest

test "foo works":
  check foo(3, 7) == 24

from strutils import contains

test "exception":
  try:
    echo foo(3, -7)
    checkpoint "should error"
    check false
  except ValueError as e:
    check e.msg == "result must be positive"
    template testStacktrace(body) =
      when defined(nimscript):
        echo "cannot test stacktrace, not available"
      elif declared(stackTraceAvailable):
        if stackTraceAvailable():
          body
        else:
          echo "cannot test stacktrace, not available"
      elif compileOption("stacktrace"):
        body
      else:
        echo "cannot test stacktrace, not available"
    testStacktrace:
      let st = getStackTrace(e)
      check "lispnimgentest.lispnim" in st
