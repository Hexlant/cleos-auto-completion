#!/bin/bash

## 2018.07.10 Sam Kim, Hexlant. (rlaace423@gmail.com)

#########################################################################
## Change this array for custom cloes binaries or shell scripts.
##
## EX) CLEOS_TARGET_NAME=( cleos cleos_mainnet.sh cleos_testnet.sh )
#########################################################################
CLEOS_TARGET_NAME=(cleos ./cleos.sh)



_cleos ()
{
	local cur prev

	local c1=(version create convert get set transfer net wallet sign push multisig wrap system)
	local c2_version=(client)
	local c2_create=(key account)
	local c2_convert=(pack_transaction unpack_transaction pack_action_data unpack_action_data)
	local c2_get=(info block account code abi table currency accounts servants transaction actions schedule transaction_id)
	local c2_set=(code abi contract account action)
	local c2_net=(connect disconnect status peers)
	local c2_wallet=(create open lock lock_all unlock import remove_key create_key list keys private_keys stop)
	local c2_push=(action transaction transactions)
	local c2_multisig=(propose propose_trx review approve unapprove cancel exec)
    local c2_wrap=(exec)
	local c2_system=(newaccount regproducer unregprod voteproducer listproducers delegatebw undelegatebw listbw bidname bidnameinfo buyram sellram claimrewards regproxy unregproxy canceldelay)
	local c3_get_currency=(balance stats)
	local c3_set_account=(permission)
	local c3_set_action=(permission)
	local c3_system_voteproducer=(proxy prods approve unapprove)

	COMPREPLY=()
	cur=${COMP_WORDS[ $COMP_CWORD ]}


	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=( $(compgen -W "${c1[*]}" -- $cur) )

	elif [ $COMP_CWORD -eq 2 ]; then
        prev=${COMP_WORDS[ $COMP_CWORD - 1 ]}

		local i=0

		for (( i=0 ; i < ${#c1[@]} ; i++ )); do
			if [ $prev == ${c1[$i]} ]; then
				eval new_arr=( '"${c2_'${prev}'[@]}"' )
				COMPREPLY=( $(compgen -W "${new_arr[*]}" -- $cur) )
			else
				continue
			fi
		done
	elif [ $COMP_CWORD -eq 3 ]; then
        prev=${COMP_WORDS[ $COMP_CWORD - 1 ]}
        prev2=${COMP_WORDS[ $COMP_CWORD - 2 ]}

		local i=0
		eval current_c2=( '"${c2_'${prev2}'[@]}"' )
		for (( i=0 ; i < ${#current_c2[@]} ; i++ )); do
			if [ $prev == ${current_c2[$i]} ]; then
				eval new_arr=( '"${c3_'${prev2}'_'${prev}'[@]}"' )
				COMPREPLY=( $(compgen -W "${new_arr[*]}" -- $cur) )
			else
				continue
			fi
		done
	fi

	return 0
} 

for (( j=0 ; j < ${#CLEOS_TARGET_NAME[@]} ; j++ )); do
	complete -F _cleos ${CLEOS_TARGET_NAME[$j]}
done

