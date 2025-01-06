Class {
	#name : #GtLZAEditorFile,
	#superclass : #GtLZAEditorEntity,
	#instVars : [
		'entities',
		'associations'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtLZAEditorFile >> addAssociation: anObject [
	self associations add: anObject
]

{ #category : #'as yet unclassified' }
GtLZAEditorFile >> addEntity: anObject [
	self entities add: anObject
]

{ #category : #accessing }
GtLZAEditorFile >> associations [
	^ associations ifNil: [ associations := OrderedCollection new ]
]

{ #category : #accessing }
GtLZAEditorFile >> associations: anObject [
	associations := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> entities [
	^ entities ifNil: [ entities := IdentitySet new ]
]

{ #category : #accessing }
GtLZAEditorFile >> entities: anObject [
	entities := anObject
]
