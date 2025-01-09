Class {
	#name : #GtLZAEditorEntity,
	#superclass : #Object,
	#instVars : [
		'node',
		'name',
		'file'
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

{ #category : #accessing }
GtLZAEditorEntity >> file [
	^ file
]

{ #category : #accessing }
GtLZAEditorEntity >> file: anObject [
	file := anObject
]

{ #category : #views }
GtLZAEditorEntity >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		stencil: [ GtLZACoder new
				model: self model;
				modelFile: self file;
				highlight: self node;
				yourself ]
]

{ #category : #accessing }
GtLZAEditorEntity >> model [
	^ self file model
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
