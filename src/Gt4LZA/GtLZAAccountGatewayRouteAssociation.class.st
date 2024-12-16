Class {
	#name : #GtLZAAccountGatewayRouteAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'account',
		'gatewayRoute'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> account [
	<MSEProperty: #account type: #GtLZAAccount opposite: #gatewayRouteAssociations>
	^ account
]

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> account: anObject [
	account := FMMultivalueLink
			on: self
			update: #gatewayRouteAssociations
			from: self account
			to: anObject
]

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> from [
	^ self gatewayRoute
]

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> gatewayRoute [
	<MSEProperty: #gatewayRoute type: #GtLZAGatewayRoute opposite: #accountAssociation>
	^ gatewayRoute
]

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> gatewayRoute: anObject [
	gatewayRoute == anObject ifTrue: [ ^ self ].
	gatewayRoute ifNotNil: [ gatewayRoute accountAssociation: nil ].
	gatewayRoute := anObject.
	gatewayRoute ifNotNil: [ gatewayRoute accountAssociation: self ]
]

{ #category : #accessing }
GtLZAAccountGatewayRouteAssociation >> to [
	^ self account
]
