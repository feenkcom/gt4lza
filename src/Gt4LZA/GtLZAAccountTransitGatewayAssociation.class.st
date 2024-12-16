Class {
	#name : #GtLZAAccountTransitGatewayAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'account',
		'transitGateway'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> account [
	<MSEProperty: #account type: #GtLZAAccount opposite: #transitGatewayAssociations>
	^ account
]

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> account: anObject [
	account := FMMultivalueLink
			on: self
			update: #transitGatewayAssociations
			from: self account
			to: anObject
]

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> from [
	^ self transitGateway
]

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> to [
	^ self account
]

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> transitGateway [
	<MSEProperty: #transitGateway type: #GtLZATransitGateway opposite: #accountAssociation>
	^ transitGateway
]

{ #category : #accessing }
GtLZAAccountTransitGatewayAssociation >> transitGateway: anObject [
	transitGateway == anObject ifTrue: [ ^ self ].
	transitGateway ifNotNil: [ transitGateway accountAssociation: nil ].
	transitGateway := anObject.
	transitGateway ifNotNil: [ transitGateway accountAssociation: self ]
]
