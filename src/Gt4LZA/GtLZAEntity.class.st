Class {
	#name : #GtLZAEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'rawData'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAEntity >> gtRawDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 10;
		object: [ self rawData ];
		view: #gtTreeFor:
]

{ #category : #initialization }
GtLZAEntity >> initialize [
	super initialize.
	rawData := Dictionary new
]

{ #category : #printing }
GtLZAEntity >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtLZAEntity >> rawData [
	^ rawData
]

{ #category : #accessing }
GtLZAEntity >> rawData: anObject [
	rawData := anObject
]
