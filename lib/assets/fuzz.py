import atheris
import sys

# This tells Atheris to instrument all functions in the `struct` and
# `example_library` modules.
with atheris.instrument_imports():
  import struct
  import nltk_model


@atheris.instrument_func  # Instrument the TestOneInput function itself
def TestOneInput(data):
  """The entry point for our fuzzer.
  This is a callback that will be repeatedly invoked with different arguments
  after Fuzz() is called.
  We translate the arbitrary byte string into a format our function being fuzzed
  can understand, then call it.
  Args:
    data: Bytestring coming from the fuzzing engine.
  """
  nltk_model.fuzz_categoriser(data)



atheris.Setup(sys.argv, TestOneInput)
atheris.Fuzz()