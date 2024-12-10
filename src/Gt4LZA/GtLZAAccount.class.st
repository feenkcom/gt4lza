Class {
	#name : #GtLZAAccount,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'email',
		'organizationalUnit',
		'type'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccount >> description [
	^ description
]

{ #category : #accessing }
GtLZAAccount >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtLZAAccount >> email [
	^ email
]

{ #category : #accessing }
GtLZAAccount >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnit [
	^ organizationalUnit
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnit: anObject [
	organizationalUnit := anObject.
	organizationalUnit addChild: self
]

{ #category : #accessing }
GtLZAAccount >> type [
	^ type
]

{ #category : #accessing }
GtLZAAccount >> type: anObject [
	type := anObject
]
