Class {
	#name : #GtLZAEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'rawData'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAEntity >> gtRawDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 10;
		object: [ self rawData ];
		view: #gtTreeFor:
]

{ #category : #'as yet unclassified' }
GtLZAEntity >> initialize [
	super initialize.
	rawData := {} asDictionary
]

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

{ #category : #accessing }
GtLZAEntity >> rawData [
	^ rawData
]

{ #category : #accessing }
GtLZAEntity >> rawData: anObject [
	rawData := anObject
]
