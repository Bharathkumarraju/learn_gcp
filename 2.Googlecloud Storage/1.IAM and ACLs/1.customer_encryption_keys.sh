gsutl has .boto directory in home directory

Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> import base64
>>> print(base64.encodestring(os.urandam(32)))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: module 'os' has no attribute 'urandam'
>>> print(base64.encodestring(os.urandom(32)))
__main__:1: DeprecationWarning: encodestring() is a deprecated alias since 3.1, use encodebytes()
b'Vci6Y9U1hLsZc+EgmbsHzpu535i5Br1FKvZbrhqM25Y=\n'
>>> print(base64.encodebytes(os.urandom(32)))
b'+VbJGv1R5kplSmXelMxfi/yvONccN9v4SYcMni8yQy4=\n'
>>>


