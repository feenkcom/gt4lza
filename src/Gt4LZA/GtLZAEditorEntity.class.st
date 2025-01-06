Class {
	#name : #GtLZAEditorEntity,
	#superclass : #Object,
	#instVars : [
		'node',
		'name'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'instance creation' }
GtLZAEditorEntity class >> name: aString node: ast [
	^ self new
		name: aString;
		node: ast;
		yourself
]

{ #category : #views }
GtLZAEditorEntity >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		object: [ node ];
		view: #gtSourceFor:
]

{ #category : #accessing }
GtLZAEditorEntity >> name [
	^ name
]

{ #category : #accessing }
GtLZAEditorEntity >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtLZAEditorEntity >> node [
	^ node
]

{ #category : #accessing }
GtLZAEditorEntity >> node: anObject [
	node := anObject
]
