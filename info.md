# Observations/Info that might come handy #

Sun, Feb 23 :: 21.58
1. Upgraded Azure server to Free Student Subscription
2. CTServer A and B were stopped and the databases were wiped for some reason. They are empty, but back alive

```
zm$> curl 13.90.224.64:6965/athos/ct/v1/get-sth
{"tree_size":0,"timestamp":1582512718880,"sha256_root_hash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=","tree_head_signature":"BAMARzBFAiAV2XkShzrYz8dnJWfgsIiWm+FkOBtG65PwZBavsnEIkgIhAP2TclsLD+rKfijOfbHQBl6ZSawkj2dbeWD5bx9xwMmh"}
zm$> curl 40.114.31.88:6965/porthos/ct/v1/get-sth
{"tree_size":0,"timestamp":1582512701368,"sha256_root_hash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=","tree_head_signature":"BAMARzBFAiEAwF2vnhlGfe4b5PjGTGHlsz6HDr1/r3isYAJjwSPQb7MCIG7xtUKp3saWJ9iQzS/SAA/lcYy3DeXatpn5FvSqm1Al"}
```

Observations:
 - both use the same Hashing algorithm and are the "same" because they are empty, so they have the same zero-hash `tree_head_signature` and zero-hash "sha256_root_hash", even though the timestamp is different
