 zm$> go run ./gossip/minimal/gossec/main.go --config=../config/gossec.cfg -alsologtostderr -v=2
I0310 21:21:25.667355   26201 instance.go:139] configured source log athos at http://40.71.200.117:6965/athos (&{Name:athos URL:http://40.71.200.117:6965/athos Log:0xc0000c2c80 MinInterval:10s})
I0310 21:21:25.667496   26201 instance.go:139] configured source log porthos at http://13.90.199.163:6965/porthos (&{Name:porthos URL:http://13.90.199.163:6965/porthos Log:0xc0000c2d70 MinInterval:10s})
I0310 21:21:25.667516   26201 instance.go:161] configured monitor gossec-in-thecloud at http://52.226.73.245:6966 (&{Name:gossec-in-thecloud URL:http://52.226.73.245:6966 HttpClient:0xc0000c2e60 lastBroadcast:map[]})
I0310 21:21:25.667542   26201 instance.go:174] configured dest Hub athos-hub at http://40.71.200.117:6965/athos (&{Name:athos-hub URL:http://40.71.200.117:6965/athos Submitter:0xc0000b20e0 MinInterval:25s lastHubSubmission:map[]})
E0310 21:21:25.667555   26201 instance.go:187] athos-hub: Overall STH retrieval rate (0.200000 Hz) higher than submission limit (0.040000 Hz) for hub, retrieved STHs may be dropped
I0310 21:21:25.667643   26201 main.go:55] **** Gossiper Starting ****
I0310 21:21:25.667657   26201 gossip.go:275] starting Gossip Broadcaster
I0310 21:21:25.667663   26201 gossip.go:267] starting Gossip Listener
I0310 21:21:25.667674   26201 gossip.go:323] [Listen] Actually Starting Listener
I0310 21:21:25.667679   26201 gossip.go:332] Listen: Created Server
I0310 21:21:25.667684   26201 gossip.go:344] Listen: Listen&Serve on :6966/ct/v1/gossip-exchange
I0310 21:21:25.667724   26201 gossip.go:261] starting Retriever(porthos)
I0310 21:21:25.667737   26201 gossip.go:404] Retriever(porthos): wait for 1.94777941s before starting...
I0310 21:21:25.667760   26201 gossip.go:261] starting Retriever(athos)
I0310 21:21:25.667773   26201 gossip.go:404] Retriever(athos): wait for 3.082153551s before starting...
I0310 21:21:27.615916   26201 gossip.go:411] Retriever(porthos): wait for 1.94777941s before starting...done
I0310 21:21:27.616067   26201 gossip.go:415] Retriever(porthos): Get STH
I0310 21:21:27.616165   26201 gossip.go:447] Get STH for source log porthos
I0310 21:21:27.616340   26201 client.go:179] GET http://13.90.199.163:6965/porthos/ct/v1/get-sth?
I0310 21:21:27.649102   26201 gossip.go:462] Retriever(porthos): got STH size=1287 timestamp=1583888369115 hash=a82658374a33039d85414da57cba1b2293e695497663972817248e43cc35efc0
E0310 21:21:27.649279   26201 gossip.go:426] Retriever(porthos): failed to NewerEntries STH: Cannot get new entries: lastSTH is (<nil>)
I0310 21:21:27.649329   26201 gossip.go:431] Retriever(porthos): received (0) new entries
I0310 21:21:27.649364   26201 gossip.go:434] Retriever(porthos): pass on STH
I0310 21:21:27.649440   26201 gossip.go:439] Retriever(porthos): wait for a 10s tick
I0310 21:21:27.649499   26201 gossip.go:298] Broadcast: Broadcasting(porthos)
I0310 21:21:27.649532   26201 gossip.go:306] Broadcaster: info (porthos)->(gossec-in-thecloud)
PostGossipExchange: Broadcasting to (http://13.90.199.163:6965/porthos) | ({http://13.90.199.163:6965/porthos {TreeSize:1287, Timestamp:1583888369115, SHA256RootHash:"qCZYN0ozA52FQU2lfLobIpPmlUl2Y5coFySOQ8w178A=", TreeHeadSignature:"BAMARjBEAiBska9MW1IYNnN5OR4pTbtr0Lzyj1DpyFuZC/NLynkRWAIgTfNZLWgt01kqlbIXPlYCK/mzwSvY78ZQnSI9Q03c8ag="} %!s(bool=true) []})
I0310 21:21:27.650185   26201 client.go:225] POST http://52.226.73.245:6966/ct/v1/gossip-exchange
PostGossipExchange HTTP Response,Body
------
&{200 OK %!s(int=200) HTTP/1.1 %!s(int=1) %!s(int=1) map[Content-Length:[381] Content-Type:[application/json] Date:[Wed, 11 Mar 2020 01:21:27 GMT]] %!s(*http.bodyEOFSignal=&{0xc0000aab80 {0 0} true 0xc000066110 <nil> 0x6fa520}) %!s(int64=381) [] %!s(bool=false) %!s(bool=false) map[] %!s(*http.Request=&{POST 0xc0000fa380 HTTP/1.1 1 1 map[Content-Type:[application/json] User-Agent:[ct-go-gossiper/1.0]] {0xc0002bc000} 0x6f8d30 391 [] false 52.226.73.245:6966 map[] map[] <nil> map[]   <nil> <nil> <nil> 0xc0000aa0c0}) %!s(*tls.ConnectionState=<nil>)}
------
{"acknowledged":true,"logUrl":"http://13.90.199.163:6965/porthos","sth":{"sth_version":0,"tree_size":1287,"timestamp":1583888369115,"sha256_root_hash":"qCZYN0ozA52FQU2lfLobIpPmlUl2Y5coFySOQ8w178A=","tree_head_signature":"BAMARjBEAiBska9MW1IYNnN5OR4pTbtr0Lzyj1DpyFuZC/NLynkRWAIgTfNZLWgt01kqlbIXPlYCK/mzwSvY78ZQnSI9Q03c8ag=","log_id":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="}}

---------I0310 21:21:27.680267   26201 gossip.go:316] Broadcaster: Retrieved Acknowledgement (porthos)->(gossec-in-thecloud)
&{%!s(bool=true) http://13.90.199.163:6965/porthos {TreeSize:1287, Timestamp:1583888369115, SHA256RootHash:"qCZYN0ozA52FQU2lfLobIpPmlUl2Y5coFySOQ8w178A=", TreeHeadSignature:"BAMARjBEAiBska9MW1IYNnN5OR4pTbtr0Lzyj1DpyFuZC/NLynkRWAIgTfNZLWgt01kqlbIXPlYCK/mzwSvY78ZQnSI9Q03c8ag="}}
I0310 21:21:28.750211   26201 gossip.go:411] Retriever(athos): wait for 3.082153551s before starting...done
I0310 21:21:28.750397   26201 gossip.go:415] Retriever(athos): Get STH
I0310 21:21:28.750565   26201 gossip.go:447] Get STH for source log athos
I0310 21:21:28.750687   26201 client.go:179] GET http://40.71.200.117:6965/athos/ct/v1/get-sth?
I0310 21:21:28.787678   26201 gossip.go:462] Retriever(athos): got STH size=3239 timestamp=1583889454947 hash=8bd0c95035060862d90ad7375c4910fa409f18b47f02d449e670af0ea99779c3
E0310 21:21:28.787840   26201 gossip.go:426] Retriever(athos): failed to NewerEntries STH: Cannot get new entries: lastSTH is (<nil>)
I0310 21:21:28.788045   26201 gossip.go:431] Retriever(athos): received (0) new entries
I0310 21:21:28.788188   26201 gossip.go:434] Retriever(athos): pass on STH
I0310 21:21:28.788475   26201 gossip.go:439] Retriever(athos): wait for a 10s tick
I0310 21:21:28.788586   26201 gossip.go:298] Broadcast: Broadcasting(athos)
I0310 21:21:28.788630   26201 gossip.go:306] Broadcaster: info (athos)->(gossec-in-thecloud)
PostGossipExchange: Broadcasting to (http://40.71.200.117:6965/athos) | ({http://40.71.200.117:6965/athos {TreeSize:3239, Timestamp:1583889454947, SHA256RootHash:"i9DJUDUGCGLZCtc3XEkQ+kCfGLR/AtRJ5nCvDqmXecM=", TreeHeadSignature:"BAMASDBGAiEA7Ic7OfQguYDSrhxVQ68vDOa6BIAZ5RDp9BuTo6VYq0gCIQCjyLs/AKrAewS7Q5ZNvJx9by2fTTDO7uyEtprw9H0W4w=="} %!s(bool=true) []})
I0310 21:21:28.789109   26201 client.go:225] POST http://52.226.73.245:6966/ct/v1/gossip-exchange
PostGossipExchange HTTP Response,Body
------
&{200 OK %!s(int=200) HTTP/1.1 %!s(int=1) %!s(int=1) map[Content-Length:[383] Content-Type:[application/json] Date:[Wed, 11 Mar 2020 01:21:28 GMT]] %!s(*http.bodyEOFSignal=&{0xc0000aacc0 {0 0} true 0xc000066110 <nil> 0x6fa520}) %!s(int64=383) [] %!s(bool=false) %!s(bool=false) map[] %!s(*http.Request=&{POST 0xc000168580 HTTP/1.1 1 1 map[Content-Type:[application/json] User-Agent:[ct-go-gossiper/1.0]] {0xc000402300} 0x6f8d30 393 [] false 52.226.73.245:6966 map[] map[] <nil> map[]   <nil> <nil> <nil> 0xc0000aa0c0}) %!s(*tls.ConnectionState=<nil>)}
------
{"acknowledged":true,"logUrl":"http://40.71.200.117:6965/athos","sth":{"sth_version":0,"tree_size":3239,"timestamp":1583889454947,"sha256_root_hash":"i9DJUDUGCGLZCtc3XEkQ+kCfGLR/AtRJ5nCvDqmXecM=","tree_head_signature":"BAMASDBGAiEA7Ic7OfQguYDSrhxVQ68vDOa6BIAZ5RDp9BuTo6VYq0gCIQCjyLs/AKrAewS7Q5ZNvJx9by2fTTDO7uyEtprw9H0W4w==","log_id":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="}}

---------I0310 21:21:28.807663   26201 gossip.go:316] Broadcaster: Retrieved Acknowledgement (athos)->(gossec-in-thecloud)
&{%!s(bool=true) http://40.71.200.117:6965/athos {TreeSize:3239, Timestamp:1583889454947, SHA256RootHash:"i9DJUDUGCGLZCtc3XEkQ+kCfGLR/AtRJ5nCvDqmXecM=", TreeHeadSignature:"BAMASDBGAiEA7Ic7OfQguYDSrhxVQ68vDOa6BIAZ5RDp9BuTo6VYq0gCIQCjyLs/AKrAewS7Q5ZNvJx9by2fTTDO7uyEtprw9H0W4w=="}}
I0310 21:21:37.616271   26201 gossip.go:415] Retriever(porthos): Get STH
I0310 21:21:37.616414   26201 gossip.go:447] Get STH for source log porthos
I0310 21:21:37.616450   26201 client.go:179] GET http://13.90.199.163:6965/porthos/ct/v1/get-sth?
I0310 21:21:37.632746   26201 gossip.go:458] Retriever(porthos): same STH as previous
I0310 21:21:37.632769   26201 gossip.go:439] Retriever(porthos): wait for a 10s tick
I0310 21:21:38.750705   26201 gossip.go:415] Retriever(athos): Get STH
I0310 21:21:38.750798   26201 gossip.go:447] Get STH for source log athos
I0310 21:21:38.750855   26201 client.go:179] GET http://40.71.200.117:6965/athos/ct/v1/get-sth?
I0310 21:21:38.769415   26201 gossip.go:458] Retriever(athos): same STH as previous
I0310 21:21:38.769443   26201 gossip.go:439] Retriever(athos): wait for a 10s tick
I0310 21:21:47.616332   26201 gossip.go:415] Retriever(porthos): Get STH
I0310 21:21:47.616471   26201 gossip.go:447] Get STH for source log porthos
I0310 21:21:47.616550   26201 client.go:179] GET http://13.90.199.163:6965/porthos/ct/v1/get-sth?
I0310 21:21:47.632933   26201 gossip.go:458] Retriever(porthos): same STH as previous
I0310 21:21:47.632950   26201 gossip.go:439] Retriever(porthos): wait for a 10s tick
I0310 21:21:48.750698   26201 gossip.go:415] Retriever(athos): Get STH
I0310 21:21:48.750772   26201 gossip.go:447] Get STH for source log athos
I0310 21:21:48.750810   26201 client.go:179] GET http://40.71.200.117:6965/athos/ct/v1/get-sth?
I0310 21:21:48.767045   26201 gossip.go:458] Retriever(athos): same STH as previous
I0310 21:21:48.767065   26201 gossip.go:439] Retriever(athos): wait for a 10s tick
^CW0310 21:21:49.387625   26201 main.go:91] Signal received: interrupt
W0310 21:21:49.387881   26201 main.go:58] Cancelling master context
I0310 21:21:49.387947   26201 gossip.go:335] Listen: termination requested
I0310 21:21:49.388081   26201 gossip.go:441] Retriever(porthos): termination requested
I0310 21:21:49.388151   26201 gossip.go:263] finished Retriever(porthos)
I0310 21:21:49.388193   26201 gossip.go:441] Retriever(athos): termination requested
I0310 21:21:49.388223   26201 gossip.go:263] finished Retriever(athos)
I0310 21:21:49.388230   26201 gossip.go:294] Broadcast: termination requested
I0310 21:21:49.388285   26201 gossip.go:277] finished Gossip Broadcaster
I0310 21:21:49.388319   26201 main.go:75] Stopping server, about to exit
I0310 21:21:49.388153   26201 gossip.go:269] finished Gossip Listener
 zm$> 

