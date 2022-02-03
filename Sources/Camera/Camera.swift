
import Network

public struct Camera {
    public private(set) var text = "Hello, World!"
    
    public init() {
    }
    
    
    private let RTAX_DST = 0    /* destination sockaddr present */
    private let RTAX_GATEWAY = 1    /* gateway sockaddr present */
    private let RTAX_NETMASK = 2    /* netmask sockaddr present */
    private let RTAX_GENMASK = 3    /* cloning mask sockaddr present */
    private let RTAX_IFP = 4    /* interface name sockaddr present */
    private let RTAX_IFA = 5    /* interface addr sockaddr present */
    private let RTAX_AUTHOR = 6    /* sockaddr for author of redirect */
    private let RTAX_BRD = 7    /* for NEWADDR, broadcast or p-p dest addr */
    private let RTAX_MAX = 8    /* size of array to allocate */
    
    internal struct rt_metrics {
        public var rmx_locks: UInt32 /* Kernel leaves these values alone */
        public var rmx_mtu: UInt32 /* MTU for this path */
        public var rmx_hopcount: UInt32 /* max hops expected */
        public var rmx_expire: Int32 /* lifetime for route, e.g. redirect */
        public var rmx_recvpipe: UInt32 /* inbound delay-bandwidth product */
        public var rmx_sendpipe: UInt32 /* outbound delay-bandwidth product */
        public var rmx_ssthresh: UInt32 /* outbound gateway buffer limit */
        public var rmx_rtt: UInt32 /* estimated round trip time */
        public var rmx_rttvar: UInt32 /* estimated rtt variance */
        public var rmx_pksent: UInt32 /* packets sent using this route */
        public var rmx_state: UInt32 /* route state */
        public var rmx_filler: (UInt32, UInt32, UInt32) /* will be used for TCP's peer-MSS cache */
    }
    
    
    internal struct rt_msghdr2 {
        public var rtm_msglen: u_short /* to skip over non-understood messages */
        public var rtm_version: u_char /* future binary compatibility */
        public var rtm_type: u_char /* message type */
        public var rtm_index: u_short /* index for associated ifp */
        public var rtm_flags: Int32 /* flags, incl. kern & message, e.g. DONE */
        public var rtm_addrs: Int32 /* bitmask identifying sockaddrs in msg */
        public var rtm_refcnt: Int32 /* reference count */
        public var rtm_parentflags: Int32 /* flags of the parent route */
        public var rtm_reserved: Int32 /* reserved field set to 0 */
        public var rtm_use: Int32 /* from rtentry */
        public var rtm_inits: UInt32 /* which metrics we are initializing */
        public var rtm_rmx: rt_metrics /* metrics themselves */
    }
    
    public func getDefaultGateway() -> String {
        var name: [Int32] = [
            CTL_NET,
            PF_ROUTE,
            0,
            0,
            NET_RT_DUMP2,
            0
        ]
        let nameSize = u_int(name.count)
        
        var bufferSize = 0
        sysctl(&name, nameSize, nil, &bufferSize, nil, 0)
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { buffer.deallocate() }
        buffer.initialize(repeating: 0, count: bufferSize)
        
        guard sysctl(&name, nameSize, buffer, &bufferSize, nil, 0) == 0 else { return "Nothing" }
        
        // Routes
        var rt = buffer
        let end = rt.advanced(by: bufferSize)
        var sa_tab: [sockaddr?]? = Array(repeating: nil, count: RTAX_MAX)
        while rt < end { // Going over the routes table
            let msg = rt.withMemoryRebound(to: rt_msghdr2.self, capacity: 1) { $0.pointee }
            
            // Addresses
            var addr = rt.advanced(by: MemoryLayout<rt_msghdr2>.stride)
            for i in 0..<RTAX_MAX {
                
                let ifName:UnsafeMutablePointer<CChar>? = UnsafeMutablePointer<CChar>.allocate(capacity: 128)
                if_indextoname(UInt32(msg.rtm_index), ifName)
                //            let x = String(cString: ifName!)
                if strcmp("en0", ifName) == 0{
                    let si = addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0.pointee }
                    let w = String(cString: inet_ntoa(si.sin_addr), encoding: .ascii)
                    //                let R = si.sin_addr.s_addr == INADDR_ANY
                    
                    
                    
                    
                    if
                        ((Int((msg.rtm_addrs )) & (RTAX_DST | RTAX_GATEWAY)) == (RTAX_DST | RTAX_GATEWAY))
                            && si.sin_addr.s_addr != INADDR_ANY
                            && sa_tab?[RTAX_DST]?.sa_family != nil
                            && (sa_tab?[RTAX_DST]?.sa_family)! == AF_INET
                            && (sa_tab?[RTAX_GATEWAY]?.sa_family) ?? 0 == AF_INET
                    {
                        return w! // This is where the default gateway is received
                    }
                }
                
                
                if (msg.rtm_addrs & (1 << i)) != 0 {// Everything besides i = 0
                    let sa_custom = addr.withMemoryRebound(to: sockaddr.self, capacity: 1) { $0.pointee }
                    sa_tab?[i] = sa_custom
                } else {
                    sa_tab?[i] = nil
                }
                
                if (msg.rtm_addrs & (1 << i)) != 0 && i == RTAX_GATEWAY  {
                    let si = addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0.pointee }
                    if si.sin_addr.s_addr == INADDR_ANY {
                        return "192.168.1.1"
                    }
                    else {
                        return String(cString: inet_ntoa(si.sin_addr), encoding: .ascii) ?? "192.168.1.1"
                    }
                }
                
                let sa = addr.withMemoryRebound(to: sockaddr.self, capacity: 1) { $0.pointee }
                addr = addr.advanced(by: Int(sa.sa_len))
            }
            
            rt = rt.advanced(by: Int(msg.rtm_msglen))
        }
        
        return "192.168.1.1"
    }
}
