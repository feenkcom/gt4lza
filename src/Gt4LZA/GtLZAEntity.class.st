Class {
	#name : #GtLZAEntity,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAEntity >> name [
	^ name
]

{ #category : #accessing }
GtLZAEntity >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
GtLZAEntity >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
