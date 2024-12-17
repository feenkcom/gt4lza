Class {
	#name : #GtLZAOrganizationalUnitTransitGatewayAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'organizationalUnit',
		'transitGateway'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> from [
	^ self transitGateway
]

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> organizationalUnit [
	<MSEProperty: #organizationalUnit type: #GtLZAOrganizationalUnit opposite: #transitGatewayAssociations>
	^ organizationalUnit
]

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> organizationalUnit: anObject [
	organizationalUnit := FMMultivalueLink
			on: self
			update: #transitGatewayAssociations
			from: self organizationalUnit
			to: anObject
]

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> to [
	^ self organizationalUnit
]

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> transitGateway [
	<MSEProperty: #transitGateway type: #GtLZATransitGateway opposite: #organizationalUnitAssociations>
	^ transitGateway
]

{ #category : #accessing }
GtLZAOrganizationalUnitTransitGatewayAssociation >> transitGateway: anObject [
	transitGateway := FMMultivalueLink
			on: self
			update: #organizationalUnitAssociations
			from: self transitGateway
			to: anObject
]
