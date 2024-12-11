Class {
	#name : #GtLZANatGateway,
	#superclass : #GtLZAEntity,
	#instVars : [
		'subnet'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZANatGateway >> subnet [
	^ subnet
]

{ #category : #accessing }
GtLZANatGateway >> subnet: anObject [
	subnet := anObject
]
