import Std
import Init.Grind.Ordered.Module
namespace Erdos302KernelEndpoints734

set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

def endpointCheck (c : Nat) : Bool :=
 (List.range 735).all (fun b => !(0 < b && b < c) || b * c % (b + c) != 0)












end Erdos302KernelEndpoints734
