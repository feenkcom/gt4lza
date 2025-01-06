Class {
	#name : #GtLZAEditorIndirectAssociation,
	#superclass : #GtLZAEditorAssociation,
	#instVars : [
		'model',
		'type'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> model [
	^ model
]

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
GtLZAEditorIndirectAssociation >> toEntity [
	^ model entityNamed: to ofType: type
]

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> type [
	^ type
]

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> type: anObject [
	type := anObject
]
