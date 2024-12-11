Class {
	#name : #GtLZATransitGatewayAttachment,
	#superclass : #GtLZAEntity,
	#instVars : [
		'transitGateway',
		'routeTableAssociations',
		'routeTablePropagations',
		'subnets'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZATransitGatewayAttachment >> gtRouteTableAssociationsFor: aView [
	<gtView>
	^ aView forward
		title: 'Route table associations';
		priority: 1;
		object: [ routeTableAssociations ];
		view: #gtRouteTablesFor:
]

{ #category : #views }
GtLZATransitGatewayAttachment >> gtRouteTablePropagationsFor: aView [
	<gtView>
	^ aView forward
		title: 'Route table propagations';
		priority: 2;
		object: [ routeTablePropagations ];
		view: #gtRouteTablesFor:
]

{ #category : #views }
GtLZATransitGatewayAttachment >> gtSubnetsFor: aView [
	<gtView>
	^ aView forward
		title: 'Subnets';
		priority: 3;
		object: [ subnets ];
		view: #gtSubnetsFor:
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> routeTableAssociations [
	^ routeTableAssociations
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> routeTableAssociations: anObject [
	routeTableAssociations := anObject
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> routeTablePropagations [
	^ routeTablePropagations
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> routeTablePropagations: anObject [
	routeTablePropagations := anObject
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> subnets [
	^ subnets
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> subnets: anObject [
	subnets := anObject
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> transitGateway [
	^ transitGateway
]

{ #category : #accessing }
GtLZATransitGatewayAttachment >> transitGateway: anObject [
	transitGateway := anObject
]
