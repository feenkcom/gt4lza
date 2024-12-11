Class {
	#name : #GtLZAGatewayRoute,
	#superclass : #Object,
	#instVars : [
		'destinationCidrBlock',
		'vpc',
		'account'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAGatewayRoute >> account [
	^ account
]

{ #category : #accessing }
GtLZAGatewayRoute >> account: anObject [
	account := anObject
]

{ #category : #accessing }
GtLZAGatewayRoute >> destinationCidrBlock [
	^ destinationCidrBlock
]

{ #category : #accessing }
GtLZAGatewayRoute >> destinationCidrBlock: anObject [
	destinationCidrBlock := anObject
]

{ #category : #accessing }
GtLZAGatewayRoute >> vpc [
	^ vpc
]

{ #category : #accessing }
GtLZAGatewayRoute >> vpc: anObject [
	vpc := anObject
]
