Class {
	#name : #GtLZARoute,
	#superclass : #GtLZAEntity,
	#instVars : [
		'destination',
		'type',
		'target'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZARoute >> destination [
	^ destination
]

{ #category : #accessing }
GtLZARoute >> destination: anObject [
	destination := anObject
]

{ #category : #accessing }
GtLZARoute >> target [
	^ target
]

{ #category : #accessing }
GtLZARoute >> target: anObject [
	target := anObject
]

{ #category : #accessing }
GtLZARoute >> type [
	^ type
]

{ #category : #accessing }
GtLZARoute >> type: anObject [
	type := anObject
]
