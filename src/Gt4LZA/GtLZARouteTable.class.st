Class {
	#name : #GtLZARouteTable,
	#superclass : #GtLZAEntity,
	#instVars : [
		'routes',
		'parent',
		'subnets',
		'transitGatewayAttachments'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZARouteTable >> addSubnet: aSubnet [
	self halt.
	subnets add: aSubnet
]

{ #category : #'as yet unclassified' }
GtLZARouteTable >> addTransitGatewayAttachment: anAttachment [
	transitGatewayAttachments add: anAttachment
]

{ #category : #views }
GtLZARouteTable >> gtRoutesFor: aView [
	<gtView>
	routes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Routes';
		priority: 1;
		items: [ routes ];
		column: 'Name' text: #name;
		column: 'Type' text: #type;
		column: 'Target' text: #target;
		column: 'Destination' text: #destination
]

{ #category : #'as yet unclassified' }
GtLZARouteTable >> initialize [
	super initialize.
	
	subnets := GtLZASubnetsGroup new.
	transitGatewayAttachments := GtLZATransitGatewayAttachmentsGroup new
]

{ #category : #accessing }
GtLZARouteTable >> parent [
	^ parent
]

{ #category : #accessing }
GtLZARouteTable >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtLZARouteTable >> routes [
	^ routes
]

{ #category : #accessing }
GtLZARouteTable >> routes: anObject [
	routes := anObject
]

{ #category : #accessing }
GtLZARouteTable >> subnets [
	^ subnets
]

{ #category : #accessing }
GtLZARouteTable >> subnets: anObject [
	subnets := anObject
]

{ #category : #accessing }
GtLZARouteTable >> transitGatewayAttachments [
	^ transitGatewayAttachments
]

{ #category : #accessing }
GtLZARouteTable >> transitGatewayAttachments: anObject [
	transitGatewayAttachments := anObject
]
