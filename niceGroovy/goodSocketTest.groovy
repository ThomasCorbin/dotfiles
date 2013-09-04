host = 'gtzdev'
InetAddress addr = InetAddress.getByName(host)
println "inet address is ${addr}"
int port = 21423
SocketAddress sockaddr = new InetSocketAddress(addr, port);
Socket sock = new Socket(); 
int timeoutMs = 500; 
//new Socket(host, port)
sock.connect(sockaddr, timeoutMs); 
println "done"
