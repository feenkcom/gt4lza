Class {
	#name : #GtLZAGatewayRoute,
	#superclass : #FAMIXSourcedEntity,
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
	account := anObject.
	account addManagedEntity: self
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
GtLZAGatewayRoute >> name [
	^ self asString
]

{ #category : #printing }
GtLZAGatewayRoute >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self vpc asString;
		nextPutAll: ', ';
		nextPutAll: self destinationCidrBlock;
		nextPut: $)
]

{ #category : #accessing }
GtLZAGatewayRoute >> vpc [
	^ vpc
]

{ #category : #accessing }
GtLZAGatewayRoute >> vpc: anObject [
	vpc := anObject.
	vpc addGatewayRoute: self
]
