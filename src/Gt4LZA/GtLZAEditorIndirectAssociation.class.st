Class {
	#name : #GtLZAEditorIndirectAssociation,
	#superclass : #GtLZAEditorAssociation,
	#instVars : [
		'type'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtLZAEditorIndirectAssociation >> toEntity [
	^ self model entityNamed: to ofType: type
]

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> type [
	^ type
]

{ #category : #accessing }
GtLZAEditorIndirectAssociation >> type: anObject [
	type := anObject
]
