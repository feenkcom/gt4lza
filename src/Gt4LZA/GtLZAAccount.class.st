Class {
	#name : #GtLZAAccount,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'email',
		'organizationalUnit',
		'type',
		'managedEntities'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAAccount >> addManagedEntity: anEntity [
	managedEntities add: anEntity
]

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

{ #category : #views }
GtLZAAccount >> gtManagedEntitiesFor: aView [
	<gtView>
	^ aView forward
		title: 'Managed entities';
		priority: 1;
		object: [ managedEntities ];
		view: #gtEntitiesFor:
]

{ #category : #'as yet unclassified' }
GtLZAAccount >> initialize [
	super initialize.
	
	managedEntities := GtLZAEntitiesGroup new
]

{ #category : #accessing }
GtLZAAccount >> managedEntities [
	^ managedEntities
]

{ #category : #accessing }
GtLZAAccount >> managedEntities: anObject [
	managedEntities := anObject
]

{ #category : #accessing }
GtLZAAccount >> managedEntitiesOfType: aClass [
	^ managedEntities select: [ :anEntity | anEntity isKindOf: aClass ]
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
