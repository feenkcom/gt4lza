Class {
	#name : #GtLZASubnetsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZASubnetsGroup >> gtSubnetsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Subnets';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Availability zone' text: #availabilityZone width: 120;
		column: 'IPv4 CIDR block' text: #ipv4CidrBlock width: 120;
		column: 'Route table' text: #routeTable
]

{ #category : #'as yet unclassified' }
GtLZASubnetsGroup >> itemType [
	^ GtLZASubnet
]
