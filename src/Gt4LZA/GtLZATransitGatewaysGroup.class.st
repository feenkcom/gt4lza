Class {
	#name : #GtLZATransitGatewaysGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZATransitGatewaysGroup >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Transit gateways';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Account' text: #account;
		column: 'Region' text: #region;
		column: 'ASN' text: #asn
]

{ #category : #accessing }
GtLZATransitGatewaysGroup >> itemType [
	^ GtLZATransitGateway
]
