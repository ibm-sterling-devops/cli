import sys
import codecs

# Fix for Python 3.12 missing cp437 encoding
# This registers UTF-8 as a fallback for legacy encodings
def search_function(encoding):
    """Fallback to UTF-8 for legacy encodings not available in Python 3.12"""
    legacy_encodings = ['cp437', 'cp850', 'cp1252', 'latin1', 'iso-8859-1']
    if encoding.lower() in legacy_encodings:
        return codecs.lookup('utf-8')
    return None

codecs.register(search_function)

# Made with Bob
