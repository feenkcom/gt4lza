Class {
	#name : #GtLZARouteTable,
	#superclass : #GtLZAEntity,
	#instVars : [
		'routes',
		'parent',
		'subnets',
		'transitGatewayAttachments',
		'gatewayRouteAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #adding }
GtLZARouteTable >> addSubnet: aSubnet [
	subnets add: aSubnet
]

{ #category : #adding }
GtLZARouteTable >> addTransitGatewayAttachment: anAttachment [
	transitGatewayAttachments add: anAttachment
]

{ #category : #accessing }
GtLZARouteTable >> gatewayRouteAssociations [
	^ gatewayRouteAssociations
]

{ #category : #accessing }
GtLZARouteTable >> gatewayRouteAssociations: anObject [
	gatewayRouteAssociations := anObject
]

{ #category : #views }
GtLZARouteTable >> gtRoutesFor: aView [
	<gtView>
	routes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Routes';
		priority: 1;
		items: [ self routes ];
		column: 'Name' text: #name;
		column: 'Type' text: #type;
		column: 'Target' text: #target;
		column: 'Destination' text: #destination
]

{ #category : #initialization }
GtLZARouteTable >> initialize [
	super initialize.
	gatewayRouteAssociations := FMNullMultivalueLink
			on: self
			opposite: #routeTable:
			selector: #gatewayRouteAssociations.
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
	^ gatewayRouteAssociations collect: #gatewayRoute
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
