//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package networks;

import node.Node;

network lstopo
{
        int spine =  2;
        int leaf = 4;
		int CTRLR_ADDRS = 10;
    types:
        channel C extends ned.DatarateChannel
        {
            parameters:
                delay = default(0.1ms);
                datarate = default(1Gbps);
        }
    submodules:
        spines [spine]: Node {
            parameters:
                address = index;
            gates:
                port[4];
        }
        
        leafs [leaf]: Node {
            parameters:
                address = index;
                
            gates:
                port[1];
        }
        
        controller : Node {
            parameters:
                address = CTRLR_ADDRS;
               
            gates:
                port[1];
        }
    connections:
	 	spines[0].port[0] <--> C <--> spines[1].port[0];
	 	spines[0].port[1] <--> C <--> leafs[0].port[0];
	 	spines[0].port[2] <--> C <--> leafs[1].port[0];
	 	spines[1].port[1] <--> C <--> leafs[2].port[0];
	 	spines[1].port[2] <--> C <--> leafs[3].port[0];	 	
	 	
}
