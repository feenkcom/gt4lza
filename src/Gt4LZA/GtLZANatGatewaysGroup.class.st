Class {
	#name : #GtLZANatGatewaysGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZANatGatewaysGroup >> gtNatGatewaysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'NAT gateways';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Subnet' text: #subnet
]
