Class {
	#name : #GtLZANatGatewaySubnetAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'natGateway',
		'subnet'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> from [
	^ self natGateway
]

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> natGateway [
	<MSEProperty: #natGateway type: #GtLZANatGateway opposite: #subnetAssociation>
	^ natGateway
]

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> natGateway: anObject [
	natGateway == anObject ifTrue: [ ^ self ].
	natGateway ifNotNil: [ natGateway subnetAssociation: nil ].
	natGateway := anObject.
	natGateway ifNotNil: [ natGateway subnetAssociation: self ]
]

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> subnet [
	<MSEProperty: #subnet type: #GtLZASubnet opposite: #natGatewayAssociations>
	^ subnet
]

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> subnet: anObject [
	subnet := FMMultivalueLink
			on: self
			update: #natGatewayAssociations
			from: self subnet
			to: anObject
]

{ #category : #accessing }
GtLZANatGatewaySubnetAssociation >> to [
	^ self subnet
]
