// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
/*
import "@chainlink/contracts/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
*/

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.2.0/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts@1.2.0/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

contract VrfGen is VRFConsumerBaseV2Plus {
   
   
/*Contract variables */
uint256 s_subscriptionId;
address s_owner;
//VRFV2PlusClient COORDINATOR;
address vrfCoordinator = 0xd9145CCE52D386f254917e481eB44e9943F39138;
bytes32 s_keyHash = 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae;
uint32 callbackGasLimit = 40000;
uint16 requestConfirmations = 5;
uint32 numWords =  3;
/*Contract variables EOF*/
    
  /* maps
  31486256351483502225997176016449258069344288517149377379165316531296405982932
  0xd9145CCE52D386f254917e481eB44e9943F39138
    mapping(uint256 => address) private requester; //request ID => address 
    mapping(address => uint256) private results; 


  /* maps EOF */


  /* modifiers */

  /* modifiers ROF */

    // constructor
    constructor(uint256 subscriptionId) VRFConsumerBaseV2Plus(vrfCoordinator) {
      
        s_owner = msg.sender;
        s_subscriptionId = subscriptionId;
    }
    /////////////////////////////////////////////////////////
    event RequestRandomWordsEvent(uint256 indexed requestId);
    function randomReq(bool enableNativePayment) external onlyOwner returns (uint256){

   uint256 requestId = s_vrfCoordinator.requestRandomWords(
        VRFV2PlusClient.RandomWordsRequest({
            keyHash: s_keyHash,
            subId: s_subscriptionId,
            requestConfirmations: requestConfirmations,
            callbackGasLimit: callbackGasLimit,
            numWords: numWords,
             extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        nativePayment: enableNativePayment
                    })
                )
        })
    );
    emit RequestRandomWordsEvent(requestId);
    return requestId;

    }



    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override{

    }



}



