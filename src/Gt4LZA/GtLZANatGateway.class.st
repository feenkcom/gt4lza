Class {
	#name : #GtLZANatGateway,
	#superclass : #GtLZAEntity,
	#instVars : [
		'subnetAssociation'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZANatGateway >> subnet [
	^ subnetAssociation ifNotNil: [ subnetAssociation subnet ]
]

{ #category : #accessing }
GtLZANatGateway >> subnetAssociation [
	<MSEProperty: #subnetAssociation type: #GtLZANatGatewaySubnetAssociation opposite: #natGateway>
	^ subnetAssociation
]

{ #category : #accessing }
GtLZANatGateway >> subnetAssociation: anObject [
	subnetAssociation := anObject
]
