Class {
	#name : #GtLZAPolicy,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'policy',
		'type',
		'organizationalUnits'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAPolicy >> description [
	^ description
]

{ #category : #accessing }
GtLZAPolicy >> description: anObject [
	description := anObject
]

{ #category : #'as yet unclassified' }
GtLZAPolicy >> exists [
	^ self policy exists
]

{ #category : #'as yet unclassified' }
GtLZAPolicy >> gtPolicyFor: aView [
	<gtView>
	self exists ifFalse: [^ aView empty].

	^ aView forward
		title: 'Policy definition';
		priority: 1;
		object: [ self policy ];
		view: #gtJsonFor:
]

{ #category : #accessing }
GtLZAPolicy >> organizationalUnits [
	^ organizationalUnits
]

{ #category : #accessing }
GtLZAPolicy >> organizationalUnits: anObject [
	organizationalUnits := anObject.

	organizationalUnits do: [ :aUnit | aUnit addChild: self ]
]

{ #category : #accessing }
GtLZAPolicy >> policy [
	^ policy
]

{ #category : #accessing }
GtLZAPolicy >> policy: anObject [
	policy := anObject
]

{ #category : #accessing }
GtLZAPolicy >> type [
	^ type
]

{ #category : #accessing }
GtLZAPolicy >> type: anObject [
	type := anObject
]
