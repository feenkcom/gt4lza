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
